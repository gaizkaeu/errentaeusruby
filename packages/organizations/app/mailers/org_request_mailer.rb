# frozen_string_literal: true

class OrgRequestMailer < ApplicationMailer
  def request_sender_notification(org_request)
    @request = Api::V1::Repositories::OrganizationRequestRepository.find(org_request)
    mail(to: @request.email, subject: 'Hemos recibido tu solicitud.')
  end

  def request_admin_notification(org_request, admin_email)
    @request = Api::V1::Repositories::OrganizationRequestRepository.find(org_request)
    mail(to: admin_email, subject: 'Hay una nueva solicitud de organización.')
  end
end
