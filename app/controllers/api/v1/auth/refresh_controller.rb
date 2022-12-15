class Api::V1::Auth::RefreshController < Api::V1::ApiBaseController
  before_action :authorize_refresh_by_access_request!
  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    @tokens = session.refresh_by_access_payload do
      raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
    end
    cookie_auth(@tokens)
      
    render 'api/v1/auth/shared/create'
  end
end
