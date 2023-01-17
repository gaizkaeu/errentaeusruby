class Api::V1::Services::LawProfRejectService < ApplicationService
  include Authorization

  def call(current_account, organization_id, lawyer_profile_id)
    organization = Api::V1::Repositories::OrganizationRepository.find(organization_id)

    authorize_with current_account, organization, :reject?

    lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find(lawyer_profile_id)

    raise Pundit::NotAuthorizedError if lawyer_profile.organization_id != organization_id

    Api::V1::Repositories::LawyerProfileRepository.update(lawyer_profile.id, { org_status: 'rejected' }, raise_error: false)
  end
end
