# frozen_string_literal: true

module Api
  module V1
    module Auth
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        def google_oauth2
          user = User.from_omniauth(auth)

          if user.present?
            sign_out_all_scopes
            sign_in user, event: :authentication
          else
            render json: {error: "error"}
          end
        end
        # You should configure your model like this:
        # devise :omniauthable, omniauth_providers: [:twitter]

        # You should also create an action method in this controller like this:
        # def twitter
        # end

        # More info at:
        # https://github.com/heartcombo/devise#omniauth

        # GET|POST /resource/auth/twitter
        # def passthru
        #   super
        # end

        # GET|POST /users/auth/twitter/callback
        # def failure
        #   super
        # end

        # protected

        # The path used when OmniAuth fails
        # def after_omniauth_failure_path_for(scope)
        #   super(scope)
        # end
        protected

        def after_omniauth_failure_path_for(_scope)
          render json: {error: "not authorized"}
        end
      
        def after_sign_in_path_for(resource_or_scope)
          stored_location_for(resource_or_scope) || root_path
        end
      
        private
      
        # def from_google_params
        #   @from_google_params ||= {
        #     uid: auth.uid,
        #     email: auth.info.email,
        #     full_name: auth.info.name,
        #     avatar_url: auth.info.image
        #   }
        # end
      
        def auth
          @auth ||= request.env['omniauth.auth']
        end
      end
    end
  end
end
