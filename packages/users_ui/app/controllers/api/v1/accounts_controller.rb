# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ::ApplicationController
      before_action :authenticate

      def index
        @users = Api::V1::Services::FindUserService.new.call(current_user, filtering_params)
        render 'accounts/index'
      end

      def show
        @user = Api::V1::Services::FindUserService.new.call(current_user, filtering_params, params[:id])
        render 'accounts/show'
      end

      def resend_confirmation
        user = User.find(params[:id])
        authorize user
        if user.resend_confirmation_instructions?
          render json: { status: 'sent' }
        else
          render json: { status: 'error' }, status: :unprocessable_entity
        end
      end

      def me
        @user = current_user
        render 'accounts/me'
      end

      def update
        @user = Api::V1::Services::UpdateUserService.new.call(current_user, params[:id], user_params)
        if @user.errors.any?
          render 'accounts/show', status: :unprocessable_entity
        else
          render 'accounts/show'
        end
      end

      private

      def user_update_params
        params.require(:user).permit(UserPolicy.new(current_user, nil).permitted_attributes_update).with_defaults(id: current_user.id)
      end

      def filtering_params
        return unless current_user.lawyer?

        params.slice(:client_first_name, :lawyer_first_name)
      end
    end
  end
end
