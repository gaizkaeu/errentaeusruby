require 'rails_helper'

describe Api::V1::Services::BlockUserService, type: :service do
  subject(:service) { described_class.new }

  let(:lawyer_record) { create(:lawyer) }
  let(:lawyer) { Api::V1::User.new(lawyer_record.attributes.symbolize_keys!) }
  let(:user) { create(:user) }

  describe '#call' do
    context 'with invalid user and lawyer' do
      it 'does raise error' do
        expect do
          service.call(lawyer, -2)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with valid user and lawyer' do
      it 'does block the user' do
        result = service.call(lawyer, user.id)
        expect(result).to be true
        user.reload
        expect(Api::V1::UserRepository.find(user.id).blocked).to be true
      end

      it 'does enqueue log job' do
        expect do
          service.call(lawyer, user.id)
        end.to have_enqueued_job(LogAccountLoginJob)
      end
    end

    context 'with invalid permissions' do
      it 'does raise error' do
        expect do
          service.call(user, lawyer.id)
        end.to raise_error(Pundit::NotAuthorizedError)
      end

      it 'does not enqueue job' do
        expect do
          expect do
            service.call(user, lawyer.id)
          end.to raise_error(Pundit::NotAuthorizedError)
        end.not_to have_enqueued_job(LogAccountLoginJob)
      end

      it 'does not block the user' do
        result = false
        expect do
          result = service.call(user, lawyer.id)
        end.to raise_error(Pundit::NotAuthorizedError)
        expect(result).to be false
        user.reload
        expect(Api::V1::UserRepository.find(user.id).blocked).to be user.blocked
      end
    end
  end
end
