require 'rails_helper'

describe Api::V1::Services::RefreshUserService, type: :service do
  subject(:service) { described_class.new }

  let(:requesting_ip) { '0.0.0.0' }

  describe '#call' do
    context 'with valid user' do
      let(:user_record) { create(:user) }

      it 'does return true' do
        authorized = service.call(user_record.id, requesting_ip)

        expect(authorized).to be true
      end

      it 'does enqueue log job' do
        expect do
          service.call(user_record.id, requesting_ip)
        end.to enqueue_job(LogAccountLoginJob)
      end
    end

    context 'with invalid user' do
      let(:user_record) { create(:blocked_user) }

      it 'does return true' do
        authorized = service.call(user_record.id, requesting_ip)

        expect(authorized).to be false
      end

      it 'does enqueue log job' do
        expect do
          service.call(user_record.id, requesting_ip)
        end.not_to enqueue_job(LogAccountLoginJob)
      end
    end
  end
end
