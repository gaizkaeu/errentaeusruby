# frozen_string_literal: true

module Api
  module V1
    class Appointment < ApplicationRecord
      belongs_to :tax_income, class_name: 'Api::V1::TaxIncome'

      MEETING_OPTIONS = %w[phone office].freeze

      validates_datetime :time, on_or_after: :today
      validates_time :time, between: ['9:00am', '8:00pm']

      private_constant :MEETING_OPTIONS

      delegate :lawyer_id, to: :tax_income
      delegate :client_id, to: :tax_income

      after_create_commit :notify_creation_to_tax_income
      after_destroy_commit :notify_deletion_to_tax_income

      validates :phone, presence: true, if: :phone?
      validates :meeting_method, inclusion: { in: MEETING_OPTIONS }

      validate do |appointment|
        tax_income = Api::V1::TaxIncomeRepository.find(appointment.tax_income_id)
        appointment.errors.add :base, "tax income doesn't accept appointment" unless tax_income.waiting_for_meeting_creation? || tax_income.waiting_for_meeting?
      end

      private

      def notify_creation_to_tax_income
        tax_income&.appointment_created!
      end

      def notify_deletion_to_tax_income
        tax_income&.appointment_deleted!
      end
    end
  end
end
