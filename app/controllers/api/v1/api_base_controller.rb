# frozen_string_literal: true

module Api
  module V1
    class ApiBaseController < ApplicationController
      include Pundit::Authorization

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      def pundit_user
        current_api_v1_user
      end
      
      private

      def user_not_authorized
        render json: {error: "not authorized"}, status: :unauthorized
      end
    end
  end
end
