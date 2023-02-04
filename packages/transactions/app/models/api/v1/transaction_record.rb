class Api::V1::TransactionRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'transactions'
  self.id_prefix = 'trn'

  attr_readonly :user_id, :organization_id, :created_at, :amount, :payment_intent_id, :metadata

  belongs_to :user, class_name: 'Api::V1::UserRecord'
  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'

  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[succeeded requires_capture refunded] }

  scope :filter_by_amount_greater_than, ->(amount) { where('amount > ?', amount) }
  scope :filter_by_amount_less_than, ->(amount) { where('amount < ?', amount) }
  scope :filter_by_status, ->(status) { where(status:) }
  scope :filter_by_user_id, ->(user_id) { where(user_id:) }
  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_payment_intent_id, ->(payment_intent_id) { where(payment_intent_id:) }
  scope :filter_by_date_after, ->(created_at) { where('created_at > ?', created_at) }
  scope :filter_by_date_before, ->(created_at) { where('created_at < ?', created_at) }
end
