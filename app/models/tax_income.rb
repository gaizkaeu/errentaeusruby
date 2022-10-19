class TaxIncome < ApplicationRecord
  belongs_to :user
  belongs_to :lawyer, class_name: "User", optional: true
  has_one :estimation
  has_one :appointment

  include AASM

  after_create_commit :assign_lawyer

  def load_price_from_estimation(estimation)
    update(price: estimation.price)
    estimation.update(tax_income: self, user_id: self.user_id)
  end

  enum state: {
    pending_assignation: 0,
    waiting_for_meeting_creation: 1,
    waiting_for_meeting: 2,
    pending_documentation: 3,
    in_progress: 4,
    finished: 5,
    rejected: -1,
  }

  aasm column: :state, enum: true do
    state :pending_assignation, initial: true
    state :waiting_for_meeting_creation
    state :waiting_for_meeting
    state :in_progress
    state :finished
    state :rejected

    event :assigned_lawyer do
      transitions from: :pending_assignation, to: :pending_meeting
    end
    event :appointment_created do
      transitions from: :waiting_for_meeting_creation, to: :waiting_for_meeting
    end
    event :appointment_deleted do
      transitions from: :waiting_for_meeting, to: :waiting_for_meeting_creation
    end
  end

  private
  def assign_lawyer
    #LawyerAssignationJob.perform_later(self)
  end
end
