# frozen_string_literal: true

class Document < ApplicationRecord
  include AASM

  belongs_to :tax_income
  belongs_to :user, class_name: 'User'
  belongs_to :lawyer, class_name: 'User'

  has_many_attached :files
  has_one_attached :exported_document

  validates :document_number, presence: true

  validates :files, content_type: ['application/pdf', 'image/png', 'image/jpg', 'image/jpeg']
  validates :files, size: { between: (1.kilobyte)..(5.megabytes)}

  enum state: {
    pending: 1,
    ready: 2
  }

  enum export_status: {
    not_exported: 0,
    export_queue: 1,
    export_successful: 2
  }

  aasm column: :state, enum: true do
    state :pending, initial: true
    state :ready

    event :uploaded_file, binding_event: :files_changed do
      transitions from: :pending, to: :pending, guard: :upload_file?
      transitions from: :pending, to: :ready, guard: :document_full? do
        after do |user, _description|
          create_history_record(:completed, user)
        end
      end
      after do |user, description|
        create_history_record(:add_image, user, description)
      end
    end

    event :delete_file, binding_event: :files_changed do
      transitions from: :ready, to: :pending
      after do |user, description|
        create_history_record(:remove_image, user, description)
      end
    end
  end

  aasm :export_status, namespace: :exportation do
    state :not_exported, initial: true
    state :export_queue
    state :export_successful

    event :files_changed do
      transitions from: :export_successful, to: :not_exported
      transitions from: :not_exported, to: :not_exported
    end
    event :export do
      transitions from: :not_exported, to: :export_queue
      after do |user, description|
        create_history_record(:export_requested, user, description)
      end
    end
    event :export_done do
      transitions from: :export_queue, to: :export_successful
    end
  end

  def upload_file?
    files.size < document_number
  end

  def document_full?
    files.size == document_number
  end

  private

  def create_history_record(action, user_id, description = '')
    DocumentHistory.create!(user: user_id, document: self, description:, action:)
  end
end
