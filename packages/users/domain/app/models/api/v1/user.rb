class Api::V1::User < ApplicationRecord
  rolify role_cname: 'Role', role_join_table_name: 'users_roles'
  self.table_name = 'users'

  include PrettyId

  SETTINGS_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'user_settings.json')
  private_constant :SETTINGS_JSON_SCHEMA

  self.id_prefix = 'usr'

  belongs_to :account, class_name: 'Account', inverse_of: :user, optional: true
  has_many :organization_memberships, class_name: 'Api::V1::OrganizationMembership', inverse_of: :user, dependent: :destroy

  delegate :email, to: :account

  validates_presence_of :first_name, :last_name, :account_type
  validates :first_name, length: { maximum: 15, minimum: 2 }
  validates :settings, json: { schema: SETTINGS_JSON_SCHEMA }

  def confirmed
    account.status == 'verified'
  end

  def admin?
    has_role?(:admin)
  end
end
