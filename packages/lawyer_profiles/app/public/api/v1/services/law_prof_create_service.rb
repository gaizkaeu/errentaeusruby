class Api::V1::Services::LawProfCreateService < ApplicationService
  include Authorization

  def call(current_account, lawyer_profile_params, raise_error: false)
    authorize_with current_account, Api::V1::LawyerProfile, :create?
    Api::V1::Repositories::LawyerProfileRepository.add(lawyer_profile_params, raise_error:)
  end
end
