# frozen_string_literal: true

class Api::V1::AccountsController < ApiBaseController
  before_action :authenticate

  def me
    user = current_user
    render json: Api::V1::Serializers::UserSerializer.new(user).serializable_hash
  end

  def stripe_customer_portal
    if Api::V1::Services::UserStripeCusPortalService.call(current_user).nil?
      render json: { error: 'No stripe customer id' }, status: :unprocessable_entity
    else
      render json: { url: portal.url }
    end
  end

  def update
    if current_user.update(user_update_params)
      render json: Api::V1::Serializers::UserSerializer.new(current_user).serializable_hash
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_update_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
