# frozen_string_literal: true
module Api
  module V1
    class TaxIncome < ApplicationRecord
      belongs_to :user
      belongs_to :lawyer, class_name: 'User', optional: true
      has_one :estimation, dependent: :destroy, required: false
      has_one :appointment, dependent: :destroy
      has_many :documents, class_name: 'Document', dependent: :destroy, inverse_of: :tax_income

      include AASM

      after_create_commit :assign_lawyer

      def load_price_from_estimation(estimation)
        estimation = Estimation.find(estimation) unless estimation.nil?
        estimation&.update!(tax_income: self, user_id:)
      end

      enum state: {
        pending_assignation: 0,
        waiting_for_meeting_creation: 1,
        waiting_for_meeting: 2,
        waiting_payment: 5,
        pending_documentation: 3,
        in_progress: 4,
        finished: 6,
        rejected: -1,
        refunded: -2
      }

      aasm column: :state, enum: true do
        state :pending_assignation, initial: true
        state :waiting_for_meeting_creation
        state :waiting_for_meeting
        state :in_progress
        state :finished
        state :rejected
        state :pending_documentation
        state :waiting_payment
        state :refunded

        event :assigned_lawyer do
          transitions from: :pending_assignation, to: :waiting_for_meeting_creation
        end
        event :appointment_created do
          transitions from: :waiting_for_meeting_creation, to: :waiting_for_meeting
        end
        event :appointment_deleted do
          transitions from: :waiting_for_meeting, to: :waiting_for_meeting_creation
        end
        event :paid do
          transitions from: :waiting_payment, to: :pending_documentation
        end
        event :refund do
          transitions to: :refunded
        end
      end

      private

      def assign_lawyer
        LawyerAssignationJob.perform_later(self)
      end
    end
  end
end
