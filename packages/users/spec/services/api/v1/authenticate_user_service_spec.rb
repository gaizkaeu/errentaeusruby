require 'rails_helper'

describe Api::V1::Services::AuthenticateUserService, type: :service do
  subject(:service) { described_class.new }

  let(:user_record) { create(:user) }
  let(:requesting_ip) { '0.0.0.0' }

  describe '#call' do
    context 'with invalid user' do
      it 'does not authenticate' do
        user, auth = service.call(user_record.email, 'wrong_password', requesting_ip)

        expect(auth).to be false
        expect(user.first_name).to eq user_record.first_name
      end
    end

    context 'with valid user' do
      it 'does authenticate' do
        user, auth = service.call(user_record.email, user_record.password, requesting_ip)

        expect(auth).to be true
        expect(user.first_name).to eq user_record.first_name
      end

      it 'does enqueue log job' do
        expect do
          service.call(user_record.email, user_record.password, requesting_ip)
        end.to enqueue_job(LogAccountLoginJob)
      end
    end
  end
end
