# frozen_string_literal: true

class LawyerNotificationJob < ApplicationJob
  def perform(params)
    # TaxIncomeMailer.lawyer_assignation_notification(params['tax_income_id'], params['lawyer_id']).deliver_now!
  end
end
