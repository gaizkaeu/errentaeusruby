require 'rails_helper'

describe Api::V1::Services::FindTaxService, type: :service do
  subject(:service) { described_class.new }

  let(:user_record) { create(:user) }
  let(:user) { Api::V1::User.new(user_record.attributes.symbolize_keys!) }
  let(:evil_record) { create(:user) }
  let(:evil) { Api::V1::User.new(evil_record.attributes.symbolize_keys!) }

  let(:tax_income) { create(:tax_income, client_id: user.id) }

  describe '#call' do
    context 'with valid params' do
      it 'finds a tax income' do
        expect(service.call(user, tax_income.id)).to eq(tax_income)
      end
    end

    context 'with unauthorized action' do
      it 'raises an error' do
        expect { service.call(evil, tax_income.id) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
