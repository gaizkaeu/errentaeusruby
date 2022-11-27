# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiBaseController
      before_action :authenticate_api_v1_user!, except: :logged_in
      after_action :verify_authorized, except: :logged_in

      def logged_in
      end

      def show
        @user = User.find(params[:id])
        authorize @user
      end

    end
  end
end
