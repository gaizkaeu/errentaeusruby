# frozen_string_literal: true

class LawyerAssignationJob < ApplicationJob
  queue_as :default

  def perform(tax_income)
    lawyer_id = User.where(account_type: 1).first&.id
    return if lawyer_id.nil?

    tax_income.waiting_for_meeting_creation! if tax_income.update!(lawyer_id:)
  end
end
