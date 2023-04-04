# frozen_string_literal: true

class OrgMembershipMailer < ApplicationMailer
  def new_notification(membership_id, message)
    @membership = Api::V1::OrganizationMembership.find(membership_id)
    @message = message
    mail(to: @membership.user.account.email, subject: "Nueva notificación. #{message['subject']}")
  end
end
