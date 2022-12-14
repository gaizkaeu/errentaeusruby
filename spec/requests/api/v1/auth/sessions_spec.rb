require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:user_params) { { email: user.email, password: user.password } }

    it 'returns http success' do
      post api_v1_auth_account_sign_in_url, params: { api_v1_user: user_params }
      expect(JSON.parse(response.body).keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post api_v1_auth_account_sign_in_url, params: { api_v1_user: { email: user.email, password: 'incorrect' } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
