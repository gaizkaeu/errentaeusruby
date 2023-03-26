class Api::V1::OrganizationInvitation < ApplicationRecord
  include PrettyId

  self.id_prefix = 'org_inv'

  has_secure_token :token

  belongs_to :organization, class_name: 'Api::V1::Organization'

  validates :role, inclusion: { in: Api::V1::OrganizationMembership::USER_TYPES }
  validates :email, uniqueness: { scope: :organization }

  attr_readonly :organization_id, :email

  def expired?
    created_at < 1.week.ago
  end

  def acceptable?(email)
    status == 'pending' && self.email == email
  end
end
