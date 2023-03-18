class Api::V1::UserRecord < ApplicationRecord
  rolify role_cname: 'Role', role_join_table_name: 'users_roles'
  self.table_name = 'users'

  include PrettyId
  include Filterable

  self.id_prefix = 'usr'

  enum account_type: { client: 0, lawyer: 1, org_manage: 2, admin: 3 }

  belongs_to :account, class_name: 'Account', inverse_of: :user, optional: true

  has_one :lawyer_profile, class_name: 'Api::V1::LawyerProfileRecord', foreign_key: :user_id, dependent: :destroy
  has_many :organization_memberships, class_name: 'Api::V1::OrganizationMembershipRecord', foreign_key: :user_id, dependent: :destroy

  scope :filter_by_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").limit(10) }
  scope :filter_by_client_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :client).limit(10) }
  scope :filter_by_lawyer_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :lawyer).limit(10) }

  validates_presence_of :first_name, :last_name, :account_type
  validates :first_name, length: { maximum: 15, minimum: 2 }
end
