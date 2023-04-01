class Api::V1::EmailContact < ApplicationRecord
  include PrettyId
  include Api::V1::Concerns::Contactable

  self.id_prefix = 'org_email'

  STATUSES = %w[pending replied].freeze
  private_constant :STATUSES

  validates :state, inclusion: { in: STATUSES }
end
