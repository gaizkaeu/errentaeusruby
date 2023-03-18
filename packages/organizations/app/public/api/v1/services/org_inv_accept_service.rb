class Api::V1::Services::OrgInvAcceptService < ApplicationService
  def call(current_account, email, organization_inv_token, raise_error: false)
    invitation = Api::V1::Repositories::OrganizationInvitationRepository.find_by!(token: organization_inv_token)

    raise Pundit::NotAuthorizedError unless invitation.acceptable?(email)

    membership = Api::V1::Repositories::OrganizationMembershipRepository.add(
      {
        organization_id: invitation.organization_id,
        user_id: current_account.id,
        role: invitation.role
      },
      raise_error:
    )

    Api::V1::OrganizationInvitationRecord.find(invitation.id).destroy!
    membership
  end
end
