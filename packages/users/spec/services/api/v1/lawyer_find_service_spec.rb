require 'rails_helper'

describe Api::V1::Services::LawyerFindService, type: :service do
  subject(:service) { described_class.new }

  let(:user_record) { create(:lawyer) }

  describe '#call' do
    context 'with valid lawyer' do
      it 'does return correct lawyer' do
        lawyer = service.call(user_record.id)

        expect(lawyer).to be_a Api::V1::User
        expect(lawyer.first_name).to eq user_record.first_name
      end

      it 'does raise error when not found' do
        expect do
          service.call(-1, raise_error: true)
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
