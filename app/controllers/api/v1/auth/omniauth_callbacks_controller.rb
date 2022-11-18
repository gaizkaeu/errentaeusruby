# frozen_string_literal: true

module Api
  module V1
    module Auth
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        def google_oauth2
          # You need to implement the method below in your model (e.g. app/models/user.rb)
          @user = User.from_omniauth(request.env['omniauth.auth'])
    
          if @user.persisted?
            sign_in @user, event: :authentication
          else
            session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
            render json: {error: "not fond"}
          end
        end
      end
    end
  end
end
