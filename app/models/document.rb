class Document < ApplicationRecord
  belongs_to :tax_income
  belongs_to :requested_by, class_name: "User"
  belongs_to :requested_to, class_name: "User"

  has_many_attached :data

  validates :data, content_type: ['application/pdf', 'image/png', 'image/jpg', 'image/jpeg']

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
