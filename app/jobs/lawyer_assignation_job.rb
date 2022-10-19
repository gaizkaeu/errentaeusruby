class LawyerAssignationJob < ApplicationJob
  queue_as :default

  def perform(tax_income)
    lawyer_id = User.where(account_type: 1).first&.id
    if (tax_income.update!(lawyer_id: lawyer_id))
      tax_income.waiting_for_meeting_creation!
    end unless lawyer_id.nil?
  end
end
