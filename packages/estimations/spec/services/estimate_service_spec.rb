require 'rails_helper'

describe Api::V1::Services::EstimateService, type: :service do
  subject(:service) { described_class.new }

  let(:valid_attributes) do
    {
      first_name: 'Gaizka',
      first_time: false,
      home_changes: 0,
      rentals_mortgages: 0,
      professional_company_activity: false,
      real_state_trade: 0,
      with_couple: false,
      income_rent: 0,
      shares_trade: 0,
      outside_alava: false
    }
  end

  let(:invalid_attributes) do
    {
      first_name: '',
      first_time: 2,
      home_changes: 0,
      rentals_mortgages: 0,
      professional_company_activity: false,
      real_state_trade: 0,
      with_couple: false,
      income_rent: 0,
      shares_trade: 0,
      outside_alava: false
    }
  end

  describe '#call' do
    context 'when the estimation is valid' do
      it 'returns the estimation' do
        estimation, jwt = service.call(valid_attributes)
        expect(estimation).to be_a(Api::V1::Estimation)
        expect(estimation.attributes.symbolize_keys!).to match(a_hash_including(valid_attributes))
        expect(jwt[:data]).to be_a(String)
        expect(estimation.token).to be_a(String)
      end

      context 'when the estimation is not valid' do
        it 'does not return jwt' do
          _estimation, jwt = service.call(invalid_attributes)
          expect(jwt).to be_nil
        end

        it 'returns the estimation with errors' do
          estimation, jwt = service.call(invalid_attributes)
          expect(estimation.errors).to be_a(ActiveModel::Errors)
          expect(estimation.errors).not_to be_empty
          expect(jwt).to be_nil
        end

        it 'raises an error if raise_error is true' do
          expect { service.call(invalid_attributes, raise_error: true) }
            .to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
