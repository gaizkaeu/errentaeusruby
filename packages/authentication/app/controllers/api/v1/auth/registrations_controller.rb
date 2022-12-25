class Api::V1::Auth::RegistrationsController < Api::V1::ApiBaseController
  def create
    user = Api::V1::Services::CreateUserService.call(user_params, request.remote_ip)
    if user.persisted?
      tokens = sign_in(user)
      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:api_v1_user).permit(:email, :password, :first_name, :last_name, :password_confirmation)
  end
end
