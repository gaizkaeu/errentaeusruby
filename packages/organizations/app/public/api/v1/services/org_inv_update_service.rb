class Api::V1::Services::OrgInvUpdateService < ApplicationService
  def call(current_account, organization_inv, organization_inv_params, raise_error: false)
    target = Api::V1::Repositories::OrganizationInvitationRepository.find(organization_inv)
    org = Api::V1::Repositories::OrganizationRepository.find(target.organization_id)
    raise Pundit::NotAuthorizedError unless org.user_is_admin?(current_account.id)

    Api::V1::Repositories::OrganizationInvitationRepository.update(organization_inv, organization_inv_params, raise_error:)
  end
end
