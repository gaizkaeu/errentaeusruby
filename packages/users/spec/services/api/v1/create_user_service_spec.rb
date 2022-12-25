require 'rails_helper'

describe Api::V1::Services::CreateUserService, type: :service do
  subject(:service) { described_class.new }

  let(:requesting_ip) { '0.0.0.0' }
  let(:valid_attributes) { attributes_for(:user) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist user' do
        user = service.call(valid_attributes, requesting_ip)
        expect(user.persisted?).to be true
      end

      it 'does enqueue log job' do
        expect do
          service.call(valid_attributes, requesting_ip)
        end.to enqueue_job(LogAccountLoginJob)
      end

      it 'does enqueue creation job' do
        expect do
          service.call(valid_attributes, requesting_ip)
        end.to enqueue_job(CreationUserJob)
      end
    end

    context 'with valid user' do
      it 'does not persist user' do
        user = service.call({ email: 'asdasd', password: 'asd' }, requesting_ip)
        expect(user.persisted?).to be false
      end

      it 'does return errors' do
        user = service.call({ email: 'asdasd', password: 'asd' }, requesting_ip)
        expect(user.errors).to be_present
      end

      it 'does raise errors' do
        expect do
          service.call({ email: 'asdasd', password: 'asd' }, requesting_ip, raise_error: true)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
