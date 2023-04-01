class Api::V1::CallContact < ApplicationRecord
  include PrettyId
  include Api::V1::Concerns::Contactable

  self.id_prefix = 'org_call'

  STATUSES = %w[pending live finished].freeze
  private_constant :STATUSES

  validates :state, inclusion: { in: STATUSES }
end
