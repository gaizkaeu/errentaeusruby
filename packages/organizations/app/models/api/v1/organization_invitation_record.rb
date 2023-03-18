class Api::V1::OrganizationInvitationRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'organization_invitations'
  self.id_prefix = 'org_inv'

  has_secure_token :token

  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'

  validates :role, inclusion: { in: Api::V1::OrganizationMembershipRecord::USER_TYPES }
  validates :email, uniqueness: { scope: :organization }

  attr_readonly :organization_id, :email
end
