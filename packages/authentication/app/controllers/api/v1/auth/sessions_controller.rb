class Api::V1::Auth::SessionsController < Api::V1::ApiBaseController
  before_action :authorize_access_request!, only: :destroy

  def create
    user, auth = Api::V1::Services::AuthenticateUserService.new.call(sign_in_params[:email], sign_in_params[:password], request.remote_ip)
    if auth
      tokens = sign_in(user)

      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def google
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com')

    user = Api::V1::Services::UserFromProviderService.new.call(params_parser_one_tap(payload))

    tokens = sign_in(user)
    render json: { csrf: tokens[:csrf] }
  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
    render json: { error: 'autenticity error' }
  end

  def destroy
    session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true, namespace: "user_#{payload['user_id']}")
    session.flush_by_access_payload
    head :no_content
  end

  private

  def params_parser_one_tap(payload)
    auth = ActiveSupport::OrderedOptions.new
    auth.info = ActiveSupport::OrderedOptions.new
    auth.info.first_name = payload['given_name']
    auth.info.last_name = payload['family_name']
    auth.info.email = payload['email']
    auth.provider = 'google_oauth2'
    auth.uid = payload['sub']
    auth
  end

  def sign_in_params
    params.require(:api_v1_user).permit(:email, :password)
  end
end
