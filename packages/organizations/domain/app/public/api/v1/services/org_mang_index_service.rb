class Api::V1::Services::OrgMangIndexService < ApplicationService
  def call(current_account)
    orgs = Api::V1::OrganizationRecord
           .joins(:memberships)
           .where(organization_memberships: { user_id: current_account.id })
           .where.not(organization_memberships: { role: 'deleted' })

    orgs.map do |org|
      Api::V1::Repositories::OrganizationRepository.map_record(org)
    end
  end
end
