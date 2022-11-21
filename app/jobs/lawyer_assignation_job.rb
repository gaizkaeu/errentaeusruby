# frozen_string_literal: true

class LawyerAssignationJob < ApplicationJob
  queue_as :default

  def perform(tax_income)
    lawyer_id = Api::V1::User.where(account_type: 1).first&.id
    return if lawyer_id.nil?

    tax = Api::V1::TaxIncome.find(tax_income)

    tax.waiting_for_meeting_creation! if tax.update!(lawyer_id:)
  end
end
