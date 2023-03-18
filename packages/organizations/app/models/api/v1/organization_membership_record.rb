class Api::V1::OrganizationMembershipRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'organization_memberships'
  self.id_prefix = 'org_mem'

  USER_TYPES = %w[admin lawyer].freeze
  public_constant :USER_TYPES

  belongs_to :user, class_name: 'Api::V1::UserRecord'
  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'

  has_one :lawyer_profile, through: :user

  validates :role, inclusion: { in: USER_TYPES }
  validates :user, uniqueness: { scope: :organization }
end
