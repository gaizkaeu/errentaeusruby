class Api::V1::Auth::RefreshController < Api::V1::ApiBaseController
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true, namespace: "user_#{claimless_payload['user_id']}")
    tokens =
      session.refresh_by_access_payload do
        raise JWTSessions::Errors::Unauthorized, 'Refresh action is performed before the expiration of the access token.'
      end
    if Api::V1::Services::RefreshUserService.new.call(session.payload['user_id'], request.remote_ip)
      cookie_auth(tokens)
      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: 'not authorized blocked account' }, status: :unauthorized
    end
  end
end
