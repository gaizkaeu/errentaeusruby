module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        before_action :configure_permitted_parameters

        protected

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
        end
      end
    end
  end
end
