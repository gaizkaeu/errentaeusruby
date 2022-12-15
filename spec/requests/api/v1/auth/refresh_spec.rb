require 'rails_helper'

RSpec.describe "RefreshController", type: :request do
    let(:access_cookie) { @tokens[:access] }
    let(:csrf_token) { @tokens[:csrf] }
  
    describe "POST #create" do
      let(:user) { create(:user) }
  
      context 'success' do
        before do
          # set expiration time to 0 to create an already expired access token
          JWTSessions.access_exp_time = 0
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          @tokens = session.login
          JWTSessions.access_exp_time = 3600
        end
  

      it do
        headers = {}
        headers[JWTSessions.csrf_header] = @csrf
        cookies[JWTSessions.access_cookie] = @access
        post api_v1_auth_account_refresh_url, headers: headers
        expect(response.body).to be_successful
        expect(JSON.parse(response.body).keys).to include('csrf')
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'failure' do
      before do
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload,
                                           refresh_by_access_allowed: true,
                                           namespace: "user_#{user.id}")
        @tokens = session.login
      end

      it do
        cookies[JWTSessions.access_cookie] = access_cookie
        post api_v1_auth_account_refresh_url, headers: {"#{JWTSessions.csrf_header}": csrf_token}
        expect(response).to have_http_status(401)
      end
    end
  end
end