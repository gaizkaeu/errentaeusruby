# frozen_string_literal: true

module Api
  module V1
    class ApiBaseController < ApplicationController
      include Pundit::Authorization

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def pundit_user
        current_api_v1_user
      end
      
      private

      def user_not_authorized
        render json: {error: "not authorized"}, status: :unauthorized
      end

      def not_found
        render json: {error: "not found"}, status: :unprocessable_entity
      end
    end
  end
end
