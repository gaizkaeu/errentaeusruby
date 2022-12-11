# frozen_string_literal: true

module Api
  module V1
    module Auth
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        def google_one_tap
          payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com')

          authentication_from_provider(params_parser_one_tap(payload))
        rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
          render json: { error: 'autenticity error' }
        end

        private

        def authentication_from_provider(params)
          @user = User.from_omniauth(params)
          if @user.persisted?
            sign_in_and_log params
            render template: 'api/v1/users/show'
          else
            render json: { error: 'found' }
          end
        end

        def sign_in_and_log(params)
          sign_in @user, event: :authentication
          @user.after_provider_authentication({ provider: params.provider, uid: params.uid })
        end

        def params_parser_one_tap(payload)
          auth = ActiveSupport::OrderedOptions.new
          auth.info = ActiveSupport::OrderedOptions.new
          auth.info.first_name = payload['given_name']
          auth.info.last_name = payload['family_name']
          auth.info.email = payload['email']
          auth.provider = 'google_oauth2'
          auth.uid = payload['sub']
          auth
        end
      end
    end
  end
end
