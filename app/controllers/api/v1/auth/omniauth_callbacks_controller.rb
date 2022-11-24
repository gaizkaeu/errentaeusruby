# frozen_string_literal: true

module Api
  module V1
    module Auth
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        def google_one_tap
          payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: "321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com")

          @user = User.from_omniauth(params_parser_one_tap(payload))
    
          if @user.persisted?
            sign_in @user, event: :authentication
          else
            session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
            render json: {error: "found"}
          end
        rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
          render json: {error: "autenticity error"}
        end

        private
        def params_parser_one_tap(payload)
            auth = ActiveSupport::OrderedOptions.new
            auth.info = ActiveSupport::OrderedOptions.new
            auth.info.first_name = payload["given_name"]
            auth.info.last_name = payload["family_name"]
            auth.info.email = payload["email"]
            auth.provider = "google_oauth2"
            auth.uid = payload["uid"]
            auth
        end
      end
    end
  end
end
