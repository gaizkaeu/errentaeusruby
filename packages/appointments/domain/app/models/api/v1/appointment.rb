# frozen_string_literal: true

class Api::V1::Appointment < ApplicationRecord
  include PrettyId
  self.table_name = 'appointments'
  self.id_prefix = 'appo'

  belongs_to :organizationm, class_name: 'Api::V1::Organization'
  belongs_to :organization_membership, class_name: 'Api::V1::OrganizationMembership', optional: true
  has_one :lawyer_profile, through: :organization_membership
  belongs_to :client, class_name: 'Api::V1::User'

  MEETING_OPTIONS = %w[phone office].freeze
  private_constant :MEETING_OPTIONS

  validates_datetime :time, on_or_after: :today
  validates_time :time, between: ['9:00am', '8:00pm']

  validates :phone, presence: true, if: :phone?
  validates :meeting_method, inclusion: { in: MEETING_OPTIONS }
end
