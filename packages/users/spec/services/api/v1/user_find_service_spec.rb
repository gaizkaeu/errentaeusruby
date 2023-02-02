require 'rails_helper'

describe Api::V1::Services::UserFindService, type: :service do
  subject(:service) { described_class.new }

  let(:requesting_ip) { '0.0.0.0' }

  describe '#call' do
    context 'with admin account' do
      let(:user_record) { create(:admin) }
      let(:user) { Api::V1::User.new(user_record.attributes.symbolize_keys!) }

      it 'does return with correct filters' do
        users = service.call(user, { name: user_record.first_name })

        expect(users).to be_a Array
        expect(users.first.first_name).to eq user_record.first_name
      end

      it 'does return with correct filters and id' do
        users = service.call(user, { name: user_record.first_name }, user_record.id)

        expect(users).to be_a Api::V1::User
        expect(users.first_name).to eq user_record.first_name
      end
    end

    context 'with client account' do
      let(:user_record) { create(:user) }
      let(:user_record2) { create(:user) }
      let(:user) { Api::V1::User.new(user_record.attributes.symbolize_keys!) }

      it 'does return error with correct filters' do
        expect do
          service.call(user, { name: user_record.first_name })
        end.to raise_error Pundit::NotAuthorizedError
      end

      it 'can access his account' do
        found_user = service.call(user, {}, user_record.id)

        expect(found_user).to be_a Api::V1::User
        expect(found_user.first_name).to eq user_record.first_name
      end

      it 'can not access others account' do
        expect do
          service.call(user, {}, user_record2.id)
        end.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
