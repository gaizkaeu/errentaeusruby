require 'rails_helper'

describe Api::V1::Services::DecodeEstimationService, type: :service do
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

  describe '#call' do
    context 'when the estimation is valid' do
      it 'returns the estimation' do
        encoded = JWT.encode({ data: valid_attributes, exp: 1.day.from_now.to_i }, Rails.application.config.x.estimation_sign_key, 'HS512')
        estimation, metadata = service.call(encoded)
        expect(metadata).to be_a(Hash)
        expect(metadata[:exp]).to be_a(Integer)
        expect(metadata[:exp]).to be(1.day.from_now.to_i)
        expect(estimation).to be_a(Api::V1::Estimation)
        expect(estimation.attributes.symbolize_keys!).to match(a_hash_including(valid_attributes))
      end
    end

    context 'when the estimation is invalid' do
      it 'returns nil' do
        encoded = JWT.encode({ data: valid_attributes, exp: 1.day.ago.to_i }, Rails.application.config.x.estimation_sign_key, 'HS512')
        estimation, metadata = service.call(encoded, raise_error: false)
        expect(metadata).to be_nil
        expect(estimation).to be_nil
      end

      it 'raises an error' do
        encoded = JWT.encode({ data: valid_attributes, exp: 1.day.ago.to_i }, Rails.application.config.x.estimation_sign_key, 'HS512')
        expect { service.call(encoded, raise_error: true) }
          .to raise_error(JWT::ExpiredSignature)
      end
    end
  end
end
