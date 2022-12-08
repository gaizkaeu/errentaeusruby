# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiBaseController
      before_action :authenticate_api_v1_user!, except: :logged_in
      after_action :verify_authorized, except: %i[logged_in index]
      after_action :verify_policy_scoped, only: :index

      def logged_in
      end

      def index
        @users = User.filter(filtering_params, policy_scope(User))
      end

      def show
        @user = User.find(params[:id])
        authorize @user
      end

      def resend_confirmation
        user = User.find(params[:id])
        authorize user
        if user.resend_confirmation_instructions?
          render json: {status: "sent"}
        else
          render json: {status: "error"}, status: :unprocessable_entity
        end
      end

      private

      def filtering_params
        return unless current_api_v1_user.lawyer?
          params.slice(:first_name)
      end
    end
  end
end
