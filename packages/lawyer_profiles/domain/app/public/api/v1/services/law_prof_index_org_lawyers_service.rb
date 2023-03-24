class Api::V1::Services::LawProfIndexOrgLawyersService < ApplicationService
  include Authorization

  def call(current_account, organization_id)
    organization = Api::V1::Repositories::OrganizationRepository.find(organization_id)

    raise Pundit::NotAuthorizedError unless organization.user_is_admin?(current_account.id)

    profiles = Api::V1::LawyerProfileRecord.joins(:organization_memberships).where(organization_memberships: { organization_id: })

    profiles.map do |profile|
      Api::V1::Repositories::LawyerProfileRepository.map_record(profile)
    end
  end
end
