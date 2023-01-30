class Api::V1::OrganizationStatsRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'organization_stats'
  self.id_prefix = 'org_stat'

  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'

  validates_uniqueness_of :organization_id, scope: [:date]

  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_date_start, ->(day) { where('date >= ?', Date.parse(day).beginning_of_day.iso8601) }
  scope :filter_by_date_end, ->(day) { where('date <= ?', Date.parse(day).beginning_of_day.iso8601) }
end
