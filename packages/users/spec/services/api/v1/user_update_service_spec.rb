require 'rails_helper'

describe Api::V1::Services::UserUpdateService, type: :service do
  subject(:service) { described_class.new }

  let(:admin_record) { create(:admin) }
  let(:admin) { Api::V1::User.new(admin_record.attributes.symbolize_keys!) }
  let(:user) { create(:user) }
  let(:valid_attributes) { { first_name: 'Gaizka', last_name: 'Mendieta' } }

  describe '#call' do
    context 'with invalid user and admin' do
      it 'does raise error' do
        expect do
          service.call(admin, -2, valid_attributes)
        end.to raise_error(ActiveRecord::RecordNotFound)
        user.reload
      end
    end

    context 'with valid user and admin' do
      it 'does block the user' do
        result = service.call(admin, user.id, valid_attributes)
        expect(result).to be_a(Api::V1::User)
        user.reload
        expect(user.attributes.symbolize_keys!).to match(a_hash_including(valid_attributes))
      end
    end

    context 'with invalid permissions' do
      it 'does raise error' do
        expect do
          service.call(user, admin.id, valid_attributes)
        end.to raise_error(Pundit::NotAuthorizedError)
      end

      it 'does not enqueue job' do
        expect do
          expect do
            service.call(user, admin.id, valid_attributes)
          end.to raise_error(Pundit::NotAuthorizedError)
        end.not_to have_enqueued_job(LogAccountLoginJob)
      end

      it 'does not block the user' do
        result = false
        prev_attr = user.attributes
        expect do
          result = service.call(user, admin.id, valid_attributes)
        end.to raise_error(Pundit::NotAuthorizedError)
        expect(result).to be false
        user.reload
        expect(user.attributes).to match(prev_attr)
      end
    end
  end
end
