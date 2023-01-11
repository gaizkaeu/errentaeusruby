# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ::ApiBaseController
      before_action :authenticate

      def index
        users = Api::V1::Services::FindUserService.new.call(current_user, filtering_params)
        render json: Api::V1::Serializers::UserSerializer.new(users).serializable_hash
      end

      def show
        @user = Api::V1::Services::FindUserService.new.call(current_user, filtering_params, params[:id])
        render 'accounts/show'
      end

      def me
        @user = current_user
        render 'accounts/me'
      end

      def update
        @user = Api::V1::Services::UpdateUserService.new.call(current_user, params[:id], user_update_params)
        if @user.errors.any?
          render json: @user.errors, status: :unprocessable_entity
        else
          render 'accounts/show'
        end
      end

      private

      def user_update_params
        params.require(:user).permit(UserPolicy.new(current_user, nil).permitted_attributes_update)
      end

      def filtering_params
        return unless current_user.lawyer?

        params.slice(:client_first_name, :lawyer_first_name)
      end
    end
  end
end
