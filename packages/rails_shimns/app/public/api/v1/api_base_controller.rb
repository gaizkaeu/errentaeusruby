# frozen_string_literal: true

module Api
  module V1
    class ApiBaseController < ActionController::API
      append_view_path(Rails.root.glob('packages/*/app/views'))
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
        @current_user ||= Api::V1::UserRecord.find(payload['user_id'])
      end

      def current_user_signed_in?
        current_user.present?
      end

      def cookie_auth(tokens)
        response.set_cookie(
          JWTSessions.access_cookie,
          value: tokens[:access],
          path: '/',
          secure: true,
          httponly: true,
          same_site: :strict,
          domain: Rails.application.config.x.domain_cookies
        )
      end

      def sign_in(user)
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true, namespace: "user_#{user.id}")
        tokens = session.login
        cookie_auth(tokens)
        tokens
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
