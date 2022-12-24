require 'rails_helper'

describe Api::V1::Services::EncodeEstimationService, type: :service do
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

  let(:estimation) { Api::V1::Estimation.new(valid_attributes) }

  describe '#call' do
    context 'when the estimation is valid' do
      it 'returns jwt' do
        encoded = service.call(estimation)
        expect(encoded).to be_a(Hash)
        expect(encoded[:data]).to be_a(String)
        expect(encoded[:exp]).to be_a(Integer)
      end

      it 'decode service works with encode service' do
        encoded = service.call(estimation)
        estimation, metadata = Api::V1::Services::DecodeEstimationService.new.call(encoded[:data])
        expect(metadata).to be_a(Hash)
        expect(metadata[:exp]).to be_a(Integer)
        expect(estimation).to be_a(Api::V1::Estimation)
        expect(estimation.attributes.symbolize_keys!).to match(a_hash_including(valid_attributes))
      end
    end
  end
end
