class Api::V1::Auth::SessionsController < Api::V1::ApiBaseController
  before_action :authorize_access_request!, only: [:destroy]

  def create
    @user = Api::V1::User.find_by!(email: sign_in_params[:email])
    if @user.authenticate(sign_in_params[:password])
      sign_in(@user)

      render :create
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def google
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com')

    authentication_from_provider(params_parser_one_tap(payload))

    render :create
  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
    render json: { error: 'autenticity error' }
  end

  def destroy
    session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true, namespace: "user_#{payload['user_id']}")
    session.flush_by_access_payload
    head :no_content
  end

  private

  def authentication_from_provider(params)
    @user = Api::V1::User.from_omniauth(params)
    raise JWTSessions::Errors::Unauthorized unless @user.persisted?

    sign_in(@user)
  end

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
