class Api::V1::LawyerProfileRecord < ApplicationRecord
  self.table_name = 'lawyer_profiles'
  include PrettyId
  include Filterable

  self.id_prefix = 'lawprof'

  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_user_id, ->(user_id) { where(user_id:) }
  scope :filter_by_org_status, ->(org_status) { where(org_status:) }
  scope :filter_by_lawyer_status, ->(lawyer_status) { where(lawyer_status:) }

  enum org_status: { pending: 0, accepted: 1, rejected: 2 }
  enum lawyer_status: { on_duty: 0, off_duty: 1 }

  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord', optional: true
  belongs_to :user, class_name: 'Api::V1::UserRecord'

  validates :user_id, uniqueness: true

  has_one_attached :avatar
end
