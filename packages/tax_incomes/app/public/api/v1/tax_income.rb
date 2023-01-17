# frozen_string_literal: true

module Api
  module V1
    class TaxIncome < ApplicationRecord
      include Filterable
      include PrettyId
      self.id_prefix = 'tax'

      scope :filter_by_state, ->(state) { where(state:) }
      scope :filter_by_client_id, ->(client_id) { where(client_id:) }
      scope :filter_by_lawyer_id, ->(lawyer_id) { where(lawyer_id:) }
      scope :filter_by_paid, ->(paid) { where(paid:) }
      scope :filter_by_captured, ->(captured) { where(captured:) }

      validate do |record|
        record.errors.add :client_id, "lawyers can't be clients" if record.client&.lawyer?
      end

      belongs_to :client, class_name: 'UserRecord'
      belongs_to :lawyer, class_name: 'LawyerProfileRecord', optional: true
      belongs_to :estimation, dependent: :destroy, optional: true

      has_one :appointment, dependent: :destroy, class_name: 'Api::V1::AppointmentRecord'
      has_many :documents, dependent: :destroy

      accepts_nested_attributes_for :estimation

      include AASM

      after_create_commit :assign_lawyer

      enum state: {
        pending_assignation: 0,
        meeting: 2,
        payment: 5,
        documentation: 3,
        in_progress: 4,
        finished: 6,
        rejected: -1,
        refunded: -2
      }

      aasm column: :state, enum: true do
        state :pending_assignation, initial: true
        state :meeting
        state :payment
        state :documentation
        state :in_progress
        state :finished
        state :rejected
        state :refunded

        event :assigned_lawyer do
          transitions from: :pending_assignation, to: :meeting, guard: :lawyer_assigned?
        end
        event :payment_succeeded do
          transitions from: :payment, to: :documentation, guard: :captured?
        end
        event :refund do
          transitions to: :refunded
        end
      end

      def appointment_assigned?
        !appointment.nil?
      end

      def lawyer_assigned?
        !lawyer_id.nil?
      end

      private

      def assign_lawyer
        unless lawyer_id.nil?
          meeting! if state == 'pending_assignation'
          return
        end

        lawyer_id = Api::V1::Repositories::LawyerProfileRepository.first&.id
        return if lawyer_id.nil?
        return unless update!(lawyer_id:)

        meeting!
        TaxIncomePubSub.publish('tax_income.lawyer_assigned', tax_income_id: id, lawyer_id:)
      end
    end
  end
end
