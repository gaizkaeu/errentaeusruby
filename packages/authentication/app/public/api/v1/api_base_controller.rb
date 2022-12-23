module Api
  module V1
    class Api::V1::ApiBaseController < ApplicationController
      include Authorization
      include ActionController::Cookies
      include JWTSessions::RailsAuthorization

      rescue_from Pundit::NotAuthorizedError, with: :permission_denied
      rescue_from JWTSessions::Errors::Unauthorized, with: :user_not_authorized

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def current_user
        @current_user ||= Api::V1::UserRepository.find(payload['user_id'])
        raise ActiveRecord::RecordNotFound if @current_user.nil?

        @current_user
      end

      def current_user_signed_in?
        current_user.present?
      end

      def cookie_auth(tokens)
        response.set_cookie(
          JWTSessions.access_cookie,
          value: tokens[:access],
          path: '/',
          secure: Rails.env.production?,
          httponly: Rails.env.production?,
          same_site: Rails.env.production? ? :strict : :lax,
          domain: Rails.env.production? ? Rails.application.config.x.domain_cookies : nil
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

      def user_not_authorized(error)
        render json: { error: "not authorized: #{error}" }, status: :unauthorized
      end

      def permission_denied
        render json: { error: 'permission denied' }, status: :forbidden
      end

      def not_found
        render json: { error: 'not found' }, status: :unprocessable_entity
      end
    end
  end
end
