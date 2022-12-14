# frozen_string_literal: true

module Api
  module V1
    class ApiBaseController < ActionController::API
      include Pundit::Authorization
      include ActionController::Cookies
      include JWTSessions::RailsAuthorization

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from JWTSessions::Errors::Unauthorized, with: :user_not_authorized

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def pundit_user
        current_user
      end

      def current_user
        @current_user ||= User.find(payload['user_id'])
      end

      def current_user_signed_in?
        current_user.present?
      end

      private

      def user_not_authorized
        render json: { error: 'not authorized' }, status: :unauthorized
      end

      def not_found
        render json: { error: 'not found' }, status: :unprocessable_entity
      end
    end
  end
end
