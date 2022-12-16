require 'rails_helper'

RSpec.describe 'Registrations' do
  describe 'POST #create' do
    let(:user_params) { { email: 'test@email.com', password: 'password', password_confirmation: 'password' } }

    it 'returns http success' do
      post api_v1_auth_account_sign_up_url, params: { api_v1_user: user_params }
      expect(response).to be_successful
      expect(JSON.parse(response.body).keys).to include('csrf')
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'creates a new user' do
      expect do
        post api_v1_auth_account_sign_up_url, params: { api_v1_user: user_params }
      end.to change(Api::V1::UserRepository, :count).by(1)
    end
  end
end
