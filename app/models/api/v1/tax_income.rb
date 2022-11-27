# frozen_string_literal: true
module Api
  module V1
    class TaxIncome < ApplicationRecord
      belongs_to :client, class_name: 'User'
      belongs_to :lawyer, class_name: 'User', optional: true
      has_one :estimation, dependent: :destroy, required: false
      has_one :appointment, dependent: :destroy
      has_many :documents, class_name: 'Document', dependent: :destroy, inverse_of: :tax_income

      accepts_nested_attributes_for :estimation

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
          transitions from: :pending_assignation, to: :waiting_for_meeting_creation, guard: :lawyer_assigned?
        end
        event :appointment_created do
          transitions from: :waiting_for_meeting_creation, to: :waiting_for_meeting, guard: :appointment_assigned?
        end
        event :appointment_deleted do
          transitions from: :waiting_for_meeting, to: :waiting_for_meeting_creation
        end
        event :paid do
          transitions from: :waiting_payment, to: :pending_documentation, guard: :payment_present?
        end
        event :refund do
          transitions to: :refunded
        end
      end

      def lawyer_assigned?
        !lawyer_id.nil?
      end

      private

      def assign_lawyer
        unless lawyer_id.nil?
          assigned_lawyer!
          return
        end

        lawyer_id = User.where(account_type: 1).first&.id
        waiting_for_meeting_creation! if update!(lawyer_id:)
      end

      def appointment_assigned?
        !appointment.nil?
      end

      def payment_present?
        !payment.nil?
      end
    end
  end
end
