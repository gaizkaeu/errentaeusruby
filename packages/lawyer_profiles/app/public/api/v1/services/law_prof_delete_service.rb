class Api::V1::Services::LawProfDeleteService < ApplicationService
  include Authorization

  def call(current_account, lawyer_profile_id)
    lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find(lawyer_profile_id)

    authorize_with current_account, lawyer_profile, :delete?

    Api::V1::Repositories::LawyerProfileRepository.update(lawyer_profile.id, { lawyer_status: :deleted }, raise_error: true)
  end
end
