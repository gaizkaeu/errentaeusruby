class OrgRequestNotificationJob < ApplicationJob
  def perform(params)
    request = Api::V1::Repositories::OrganizationRequestRepository.find(params['organization_request_id'])

    return unless request.persisted?

    OrgRequestMailer.request_sender_notification(request.id).deliver_later

    OrgRequestMailer.request_admin_notification(request.id, 'gaizkaurdangarin@gmail.com').deliver_later
  end
end
