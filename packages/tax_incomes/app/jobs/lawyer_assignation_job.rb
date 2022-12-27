# frozen_string_literal: true

class LawyerAssignationJob < ApplicationJob
  def perform(tax_income)
    lawyer_id = Api::V1::UserRepository.where(account_type: 1).first&.id
    return if lawyer_id.nil?

    tax = Api::V1::TaxIncomeRecord.find(tax_income)

    tax.meeting! if tax.update!(lawyer_id:)
  end
end
