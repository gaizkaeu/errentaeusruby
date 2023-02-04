require 'rails_helper'

describe Api::V1::Services::TaxPaymentCapturedService, type: :service do
  subject(:service) { described_class.new }

  let(:user_r) { create(:user) }
  let(:user) { Api::V1::User.new(user_r.attributes.symbolize_keys!) }
  let(:tax_income) { create(:tax_income, client_id: user.id) }

  let(:event_data) do
    {
      data: {
        object: {
          id: 'pi_1H8Z2c2eZvKYlo2C5Z0Z0Z0Z',
          amount: 1000,
          amount_capturable: 0,
          status: 'succeeded',
          metadata: {
            tax_income_id: tax_income.id,
            user_id: user.id,
            organization_id: tax_income.organization_id
          }
        }
      }
    }
  end

  describe '#call' do
    context 'when tax income is waiting payment' do
      it 'changes capture to true' do
        tax_income.payment!
        expect { service.call(event_data) }
          .to change { tax_income.reload.captured? }
          .from(false).to(true)
      end

      it 'creates a transaction' do
        tax_income.payment!
        expect { service.call(event_data) }
          .to change(Api::V1::Repositories::TransactionRepository, :count)
          .by(1)
      end

      it 'creates a transaction with correct params' do
        tax_income.payment!
        service.call(event_data)
        transaction = Api::V1::Repositories::TransactionRepository.last
        expect(transaction.amount).to eq(1000)
        expect(transaction.metadata['tax_income_id']).to eq(tax_income.id)
        expect(transaction.user_id).to eq(user.id)
        expect(transaction.organization_id).to eq(tax_income.organization_id)
      end
    end
  end
end
