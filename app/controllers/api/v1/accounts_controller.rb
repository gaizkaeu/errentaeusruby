module Api::V1
    class AccountsController < ApplicationController
        def logged_in
           render json: {logged_in: api_v1_user_signed_in?, user: current_api_v1_user}
        end
    end
end