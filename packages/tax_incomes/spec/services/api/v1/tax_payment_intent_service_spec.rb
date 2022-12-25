require 'rails_helper'
require 'stripe'

describe Api::V1::Services::TaxPaymentIntentService, type: :service do
  subject(:service) { described_class.new }

  let(:user_r) { create(:user) }
  let(:user) { Api::V1::User.new(user_r.attributes.symbolize_keys!) }
  let(:evil_r) { create(:user) }
  let(:evil) { Api::V1::User.new(evil_r.attributes.symbolize_keys!) }
  let(:tax_income) { build(:tax_income_with_lawyer, client_id: user.id) }

  describe '#call' do
    context 'when tax income is not found' do
      it 'raises an error' do
        expect { service.call(nil, -1) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when tax income price present' do
      before { tax_income.update!(state: :waiting_payment, price: 2000) }

      it 'creates a payment intent correctly' do
        expect(service.call(user, tax_income.id)).not_to be_nil
        tax_income.reload
        expect(tax_income.payment).not_to be_nil
        retrieved_payment_intent = Stripe::PaymentIntent.retrieve(tax_income.payment)
        expect(retrieved_payment_intent['amount']).to eq(tax_income.price)
        expect(retrieved_payment_intent['metadata']['id']).to eq(tax_income.id.to_s)
        expect(retrieved_payment_intent['customer']).to eq(user.stripe_customer_id)
      end

      it 'does not create a new payment intent if previous is valid' do
        expect(service.call(user, tax_income.id)).not_to be_nil
        prev = tax_income.payment
        prev_amount = tax_income.price
        expect(service.call(user, tax_income.id)).not_to be_nil
        expect(tax_income.payment).to eq(prev)
        expect(tax_income.price).to eq(prev_amount)
      end

      it 'creates a new payment intent if previous is not valid' do
        expect(service.call(user, tax_income.id)).not_to be_nil
        prev = tax_income.payment
        prev_amount = tax_income.price
        tax_income.update!(price: 3000)
        tax_income.reload
        expect(service.call(user, tax_income.id)).not_to be_nil
        tax_income.reload
        expect(tax_income.payment).not_to eq(prev)
        expect(tax_income.price).not_to eq(prev_amount)
      end
    end

    context 'when tax income has no price' do
      before { tax_income.update!(state: :waiting_payment, price: nil) }

      it 'does not create a payment intent' do
        expect(service.call(user, tax_income.id)).to be_nil
        tax_income.reload
        expect(tax_income.payment).to be_nil
      end

      it 'does raise an error if raise_error is true' do
        expect { service.call(user, tax_income.id, raise_error: true) }
          .to raise_error(StandardError)
      end

      it 'does return nil if raise_error is false' do
        expect(service.call(user, tax_income.id, raise_error: false)).to be_nil
      end
    end

    context 'when user not authorized' do
      before { tax_income.update!(state: :waiting_payment, price: nil) }

      it 'raises an error' do
        expect { service.call(evil, tax_income.id) }
          .to raise_error(Pundit::NotAuthorizedError)
      end

      it 'does not create a payment intent' do
        expect { service.call(evil, tax_income.id) }
          .to raise_error(Pundit::NotAuthorizedError)
        tax_income.reload
        expect(tax_income.payment).to be_nil
      end
    end
  end
end
