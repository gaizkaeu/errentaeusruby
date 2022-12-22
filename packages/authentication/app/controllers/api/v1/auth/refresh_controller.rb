class Api::V1::Auth::RefreshController < Api::V1::ApiBaseController
  before_action :authorize_refresh_by_access_request!
  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens =
      session.refresh_by_access_payload do
        raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
      end
    UserPubSub.publish('user.refresh_token', user_id: session.payload['user_id'], ip: request.remote_ip, action: 1)

    cookie_auth(tokens)

    render json: { csrf: tokens[:csrf] }
  end
end
