class TaxIncome < ApplicationRecord
  belongs_to :user
  has_one :estimation

  

  include AASM

  enum state: {
    initial: 0,
    rejected: 1,
    approved: 2,
    pending_documentation: 3,
    in_progress: 4,
    finished: 5
  }

  aasm column: :state, enum: true do
    state :initial, initial: true
    state :pending_meeting
    state :approved
    state :rejected
    state :pending_documentation
    state :in_progress
    state :finished
  end

  def load_price_from_estimation(estimation)
    update(price: estimation.price)
    estimation.update(tax_income: self)
  end
end
