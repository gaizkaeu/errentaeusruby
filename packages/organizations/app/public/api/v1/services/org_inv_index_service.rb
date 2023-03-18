class Api::V1::Services::OrgInvIndexService < ApplicationService
  include Authorization

  def call(current_account, org_id)
    org = Api::V1::Repositories::OrganizationRepository.find(org_id)

    raise Pundit::NotAuthorizedError unless org.user_is_admin?(current_account.id)

    invs = Api::V1::OrganizationInvitationRecord.where(organization_id: org_id)
                                                .where('created_at > ?', 1.week.ago)
                                                .where(status: 'pending')

    invs.map do |inv|
      Api::V1::Repositories::OrganizationInvitationRepository.map_record(inv)
    end
  end
end
