class Api::V1::Services::OrgCreateService < ApplicationService
  include Authorization

  def call(current_account, organization_params)
    authorize_with current_account, Api::V1::Organization, :create?
    Api::V1::OrganizationRecord.transaction do
      organization = Api::V1::OrganizationRecord.create!(organization_params)
      Api::V1::OrganizationMembershipRecord.create!(
        user_id: current_account.id,
        organization_id: organization.id,
        role: 'admin'
      )
      organization
    end
  end
end
