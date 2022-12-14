class Api::V1::Auth::RegistrationsController < Api::V1::ApiBaseController
  def create
    @user = Api::V1::User.new(user_params)
    if @user.save
      payload = { user_id: @user.id }
      session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
      @tokens = session.login
      cookie_auth(@tokens)
      render :create
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:api_v1_user).permit(:email, :password, :first_name, :last_name, :password_confirmation)
  end

  private

  def cookie_auth(tokens)
    response.set_cookie(
      JWTSessions.access_cookie,
      value: tokens[:access],
      domain: '*.errenta.eus',
      httponly: true,
      secure: Rails.env.production?
    )
  end
end
