class Api::V1::Auth::RegistrationsController < Api::V1::ApiBaseController
  def create
    @user = Api::V1::User.new(user_params)
    if @user.save
      sign_in(@user)
      render :create
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:api_v1_user).permit(:email, :password, :first_name, :last_name, :password_confirmation)
  end
end
