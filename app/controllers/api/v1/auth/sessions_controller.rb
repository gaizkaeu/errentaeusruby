class Api::V1::Auth::SessionsController < Api::V1::ApiBaseController
  def create
    @user = Api::V1::User.find_by!(email: sign_in_params[:email])
    if @user.authenticate(sign_in_params[:password])
      payload = { user_id: @user.id }
      session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
      @tokens = session.login
      cookie_auth(@tokens)

      render :create
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def google_one_tap
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com')

    authentication_from_provider(params_parser_one_tap(payload))

    render :create
  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
    render json: { error: 'autenticity error' }
  end

  private

  def authentication_from_provider(params)
    @user = User.from_omniauth(params)
    raise JWTSessions::Errors::Unauthorized unless @user.persisted?

    payload = { user_id: @user.id }
    session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
    @tokens = session.login
    cookie_auth(@tokens)
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
