# frozen_string_literal: true

class Api::V1::Auth::SessionsController < Devise::SessionsController
  respond_to :json
  after_action :add_csrf_token_to_json_request_header
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def add_csrf_token_to_json_request_header
    if request.xhr? && !request.get? && protect_against_forgery?
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end
end
