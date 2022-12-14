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

  def sign_in_params
    params.require(:api_v1_user).permit(:email, :password)
  end

  private

  def cookie_auth(tokens)
    response.set_cookie(
      JWTSessions.access_cookie,
      value: tokens[:access],
      path: '/',
      secure: true,
      httponly: true,
      same_site: :strict,
      domain: Rails.application.config.x.frontend_host
    )
  end
end
