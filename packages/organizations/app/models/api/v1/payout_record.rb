class Api::V1::PayoutRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'payouts'
  self.id_prefix = 'pyo'

  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  attr_readonly :organization_id, :created_at, :amount

  enum status: { pending: 0, paid: 1, failed: 2 }

  scope :filter_by_amount_greater_than, ->(amount) { where('amount > ?', amount) }
  scope :filter_by_amount_less_than, ->(amount) { where('amount < ?', amount) }
  scope :filter_by_status, ->(status) { where(status:) }
  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_date_after, ->(created_at) { where('created_at > ?', created_at) }
  scope :filter_by_date_before, ->(created_at) { where('created_at < ?', created_at) }
end
