class Api::V1::OrganizationMembership < ApplicationRecord
  include PrettyId

  self.id_prefix = 'org_mem'

  USER_TYPES = %w[admin lawyer].freeze
  public_constant :USER_TYPES

  belongs_to :user, class_name: 'Api::V1::User'
  belongs_to :organization, class_name: 'Api::V1::Organization'

  delegate :first_name, to: :user
  delegate :last_name, to: :user

  validates :role, inclusion: { in: USER_TYPES }
  validates :user, uniqueness: { scope: :organization }

  def admin?
    role == 'admin'
  end

  def deleted?
    role == 'deleted'
  end
end
