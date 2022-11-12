# frozen_string_literal: true
module Api
  module V1
    class Appointment < ApplicationRecord
      belongs_to :tax_income

      delegate :lawyer, to: :tax_income, allow_nil: false
      delegate :client, to: :tax_income, allow_nil: false

      after_create_commit :notify_creation_to_tax_income
      after_destroy_commit :notify_deletion_to_tax_income

      validates :phone, presence: true, if: :phone?

      enum method: {
        phone: 0,
        office: 1
      }

      private

      def notify_creation_to_tax_income
        tax_income.appointment_created!
      end

      def notify_deletion_to_tax_income
        tax_income.appointment_deleted!
      end
    end
end
end