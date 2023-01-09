# frozen_string_literal: true

module Api
  module V1
    class AppointmentRecord < ApplicationRecord
      include PrettyId
      self.table_name = 'appointments'
      self.id_prefix = 'appo'

      include Filterable

      belongs_to :tax_income, class_name: 'Api::V1::TaxIncome', optional: true
      belongs_to :lawyer, class_name: 'Api::V1::UserRecord'
      belongs_to :client, class_name: 'Api::V1::UserRecord'

      scope :filter_by_tax_income_id, ->(tax_income_id) { where(tax_income_id:) }
      scope :filter_by_client_id, ->(client_id) { where(client_id:) }
      scope :filter_by_lawyer_id, ->(lawyer_id) { where(lawyer_id:) }
      scope :filter_by_past_appointments, -> { where('time < ?', Time.now.iso8601) }
      scope :filter_by_future_appointments, -> { where('time >= ?', Time.now.iso8601) }
      scope :filter_by_after_date, ->(day) { where('time >= ?', Date.parse(day).beginning_of_day.iso8601) }
      scope :filter_by_before_date, ->(day) { where('time < ?', Date.parse(day).beginning_of_day.iso8601) }
      scope :filter_by_day, ->(day) { where('time >= ? AND time < ?', Date.parse(day).beginning_of_day.iso8601, Date.parse(day).end_of_day.iso8601) }
      scope :filter_by_date_range, ->(range) { where('time >= ? AND time < ?', Date.parse(range[:start_date]).beginning_of_day.iso8601, Date.parse(range[:end_date]).end_of_day.iso8601) }

      MEETING_OPTIONS = %w[phone office].freeze

      validates_datetime :time, on_or_after: :today
      validates_time :time, between: ['9:00am', '8:00pm']

      private_constant :MEETING_OPTIONS

      validates :phone, presence: true, if: :phone?
      validates :meeting_method, inclusion: { in: MEETING_OPTIONS }

      validate do |appointment|
        next if appointment.tax_income_id.blank?

        tax_income = Api::V1::TaxIncomeRepository.find(appointment.tax_income_id)
        appointment.errors.add :base, "tax income doesn't accept appointment" unless tax_income.meeting?
      end
    end
  end
end
