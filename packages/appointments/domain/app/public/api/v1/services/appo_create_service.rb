class Api::V1::Services::AppoCreateService < ApplicationService
  include Authorization

  def call(current_account, appointment_params, raise_error: false); end
end
