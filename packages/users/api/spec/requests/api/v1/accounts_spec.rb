require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :request do
  let(:user) { create(:user) }

  context 'signed_in user' do 

    before do
      sign_in user
    end

    describe 'AUTHORIZED_GET #me' do
      it 'returns a successful response' do
        authorized_get logged_in_api_v1_accounts_path
        expect(response).to have_http_status(:success)
      end

      it 'returns the serialized user object' do
        authorized_get logged_in_api_v1_accounts_path
        expect(response.body).to eq(Api::V1::Serializers::UserSerializer.new(user).serializable_hash.to_json)
      end
    end

    describe 'AUTHORIZED_POST #stripe_customer_portal' do

      it 'returns a successful response' do
        
        authorized_post stripe_customer_portal_api_v1_accounts_path
        expect(response).to have_http_status(:success)
      end

    end

    describe 'AUTHORIZED_PATCH #update' do
      let(:new_first_name) { 'New First Name' }
      let(:new_last_name) { 'New Last Name' }
      let(:params) { { user: { first_name: new_first_name, last_name: new_last_name } } }

      context 'with valid parameters' do
        it 'updates the user object' do
          
          authorized_patch api_v1_account_path(user), params: params
          user.reload
          expect(user.first_name).to eq(new_first_name)
          expect(user.last_name).to eq(new_last_name)
        end

        it 'returns a successful response' do
          
          authorized_patch api_v1_account_path(user), params: params
          expect(response).to have_http_status(:success)
        end

        it 'returns the serialized user object' do
          
          authorized_patch api_v1_account_path(user), params: params
          expect(response.body).to eq(Api::V1::Serializers::UserSerializer.new(user.reload).serializable_hash.to_json)
        end
      end

      context 'with invalid parameters' do
        before do
          user.update(first_name: 'New first_name', last_name: 'New last_name')
        end

        let(:new_first_name) { '' }

        it 'does not update the user object' do
          
          authorized_patch api_v1_account_path(user), params: params
          user.reload
          expect(user.first_name).not_to eq(new_first_name)
          expect(user.last_name).not_to eq('Original Last Name')
        end
      end
    end
  end
end