class Api::V1::Services::OrgMemDestroyService < ApplicationService
  def call(current_account, organization_mem, raise_error: false)
    target = Api::V1::Repositories::OrganizationMembershipRepository.find(organization_mem)
    org = Api::V1::Repositories::OrganizationRepository.find(target.organization_id)
    raise Pundit::NotAuthorizedError unless org.user_is_admin?(current_account.id)

    Api::V1::OrganizationMembershipRecord.find(organization_mem).destroy!
    true
  end
end
