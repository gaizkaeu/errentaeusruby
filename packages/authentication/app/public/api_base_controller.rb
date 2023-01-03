class ApiBaseController < ApplicationController
  include Authorization
  include ActionController::Cookies

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def current_user
    Api::V1::User.new(rodauth.rails_account.user.attributes.symbolize_keys!)
  end
  helper_method :current_user # skip if inheriting from ActionController::API

  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end

  def alive
    render json: { success: 'i am alive!' }
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
