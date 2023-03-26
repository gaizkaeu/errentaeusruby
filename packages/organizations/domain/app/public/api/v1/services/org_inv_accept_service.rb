class Api::V1::Services::OrgInvAcceptService < ApplicationService
  def call(current_account, email, organization_inv_token)
    invitation = Api::V1::OrganizationInvitation.find_by!(token: organization_inv_token)

    raise Pundit::NotAuthorizedError unless invitation.acceptable?(email)

    membership = Api::V1::OrganizationMembership.create!(
      organization_id: invitation.organization_id,
      user_id: current_account.id,
      role: invitation.role
    )

    Api::V1::OrganizationInvitation.find(invitation.id).destroy!
    membership
  end
end
