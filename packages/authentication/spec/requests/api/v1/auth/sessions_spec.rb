require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:user_params) { { email: user.email, password: user.password } }

    it 'returns http success' do
      post api_v1_auth_account_sign_in_url, params: { api_v1_user: user_params }
      expect(JSON.parse(response.body).keys).to include('csrf')
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post api_v1_auth_account_sign_in_url, params: { api_v1_user: { email: user.email, password: 'incorrect' } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'logout DELETE #destroy' do
    context 'with no logged in' do
      it 'returns unauthorized http status' do
        delete api_v1_auth_account_sign_out_url
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with logged in' do
      before do
        sign_in(user)
      end

      it 'returns http success with valid tokens' do
        authorized_delete api_v1_auth_account_sign_out_url
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
