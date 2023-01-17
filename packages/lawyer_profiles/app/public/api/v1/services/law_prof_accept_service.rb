class Api::V1::Services::LawProfAcceptService < ApplicationService
  include Authorization

  def call(current_account, organization_id, lawyer_profile_id)
    organization = Api::V1::Repositories::OrganizationRepository.find(organization_id)

    authorize_with current_account, organization, :accept?

    lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find_by!(id: lawyer_profile_id, org_status: :pending)

    raise Pundit::NotAuthorizedError if lawyer_profile.organization_id != organization_id

    Api::V1::Repositories::LawyerProfileRepository.update(lawyer_profile.id, { org_status: 'accepted' }, raise_error: false)
  end
end
