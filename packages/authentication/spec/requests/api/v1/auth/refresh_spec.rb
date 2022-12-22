require 'rails_helper'

RSpec.describe 'RefreshController' do
  describe 'POST #create' do
    # rubocop:disable RSpec/InstanceVariable
    context 'when logged in' do
      let(:user) { create(:user) }

      before do
        # set expiration time to 0 to create an already expired access token
        JWTSessions.access_exp_time = 0
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
        @tokens = session.login
        JWTSessions.access_exp_time = 3600
      end

      it do
        headers = {}
        headers[JWTSessions.csrf_header] = @tokens[:csrf]
        cookies[JWTSessions.access_cookie] = @tokens[:access]
        post api_v1_auth_account_refresh_url, headers: headers
        expect(response).to be_successful
        expect(JSON.parse(response.body).keys).to include('csrf')
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'when logged in but account blocked' do
      let(:user) { create(:blocked_user) }

      before do
        # set expiration time to 0 to create an already expired access token
        JWTSessions.access_exp_time = 0
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
        @tokens = session.login
        JWTSessions.access_exp_time = 3600
      end

      it do
        headers = {}
        headers[JWTSessions.csrf_header] = @tokens[:csrf]
        cookies[JWTSessions.access_cookie] = @tokens[:access]
        post api_v1_auth_account_refresh_url, headers: headers
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('not authorized blocked account')
        expect(response.cookies[JWTSessions.access_cookie]).not_to be_present
      end
    end

    context 'when not logged in' do
      let(:user) { create(:user) }

      before do
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true, namespace: "user_#{user.id}")
        @tokens = session.login
      end

      it do
        cookies[JWTSessions.access_cookie] = @tokens[:access]
        post api_v1_auth_account_refresh_url, headers: { "#{JWTSessions.csrf_header}": @tokens[:csrf] }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    # rubocop:enable RSpec/InstanceVariable
  end
end
