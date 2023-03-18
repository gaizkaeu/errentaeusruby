class Api::V1::Services::OrgMemIndexService < ApplicationService
  include Authorization

  def call(current_account, org_id)
    org = Api::V1::Repositories::OrganizationRepository.find(org_id)

    raise Pundit::NotAuthorizedError unless org.user_is_admin?(current_account.id)

    Api::V1::Repositories::OrganizationMembershipRepository.where(organization_id: org_id)
  end
end
