class Document < ApplicationRecord
  belongs_to :tax_income
  has_one_attached :data

  include AASM

  enum state: {
    created: 0,
    uploaded: 1,
    ready: 2,
  }

  aasm column: :state, enum: true do
    state :created, initial: true
    state :uploaded
    state :ready

    event :uploaded_file do
      transitions from: :created, to: :uploaded
    end
    event :processed do
      transitions from: :uploaded, to: :ready
    end
    event :deleted_file do
      transitions to: :created
    end
  end

end
