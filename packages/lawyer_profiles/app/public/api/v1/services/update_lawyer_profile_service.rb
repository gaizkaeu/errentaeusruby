class Api::V1::Services::UpdateLawyerProfileService < ApplicationService
  include Authorization

  def call(current_account, lawyer_profile, lawyer_profile_params, raise_error: false)
    target = Api::V1::Repositories::LawyerProfileRepository.find(lawyer_profile)
    authorize_with current_account, target, :update?
    Api::V1::Repositories::LawyerProfileRepository.update(lawyer_profile, lawyer_profile_params, raise_error:)
  end
end
