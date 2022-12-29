require 'rails_helper'

describe Api::V1::Services::TaxPaymentCaptureService, type: :service do
  subject(:service) { described_class.new }

  let(:user_r) { create(:user) }
  let(:user) { Api::V1::User.new(user_r.attributes.symbolize_keys!) }
  let(:tax_income) { create(:tax_income, client_id: user.id) }

  describe '#call' do
    context 'when tax income is waiting payment' do
      it 'changes capture to true' do
        tax_income.payment!
        Api::V1::Services::TaxPaymentIntentService.new.call(user, tax_income.id)
        tax_income.reload
        event = { data: { object: { id: tax_income.payment_intent_id, amount_capturable: 1000 }, metadata: { type: 'tax_invoice' } } }
        expect { service.call(event) }
          .to change { tax_income.reload.captured? }
          .from(false).to(true)
      end
    end
  end
end
