class Api::V1::LawyerProfileRecord < ApplicationRecord
  include PrettyId
  include Filterable

  self.table_name = 'lawyer_profiles'
  self.id_prefix = 'lawprof'

  acts_as_taggable_on :skills

  validates :user, uniqueness: true

  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_user_id, ->(user_id) { where(user_id:) }
  scope :filter_by_lawyer_status, ->(lawyer_status) { where(lawyer_status:) }

  belongs_to :user, class_name: 'Api::V1::UserRecord'
  has_many :organization_memberships, class_name: 'Api::V1::OrganizationMembershipRecord', through: :user

  has_one_attached :avatar
end
