class OrgNotifyToAllMembersJob < ApplicationJob
  def perform(params)
    org_id = params['organization_id']

    Api::V1::Organization.find(org_id).memberships.each do |member|
      OrgMembershipMailer.new_notification(member.id, params['message']).deliver_later
    end
  end
end
