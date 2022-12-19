# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiBaseController
      before_action :authorize_access_request!

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
        @current_user = current_user
        render 'accounts/me'
      end

      private

      def filtering_params
        return unless current_user.lawyer?

        params.slice(:client_first_name, :lawyer_first_name)
      end
    end
  end
end
