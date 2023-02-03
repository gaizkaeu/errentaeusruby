class Api::V1::LawyerProfileRecord < ApplicationRecord
  self.table_name = 'lawyer_profiles'
  include PrettyId
  include Filterable

  self.id_prefix = 'lawprof'

  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_user_id, ->(user_id) { where(user_id:) }
  scope :filter_by_org_status,
        lambda { |org_status_values|
          return all if org_status_values.blank?

          where(org_status: org_statuses.values_at(*Array(org_status_values)))
        }
  scope :filter_by_lawyer_status, ->(lawyer_status) { where(lawyer_status:) }

  enum org_status: { pending: 0, accepted: 1 }
  enum lawyer_status: { off_duty: 0, on_duty: 1, deleted: 2 }

  belongs_to :organization, class_name: 'Api::V1::OrganizationRecord'
  belongs_to :user, class_name: 'Api::V1::UserRecord'
  has_one_attached :avatar

  validates :user_id, uniqueness: { scope: :organization_id }

  attr_readonly :organization_id, :user_id

  validate :org_status_cannot_be_changed
  validate :deleted_lawyer_cannot_be_updated

  def org_status_cannot_be_changed
    errors.add(:org_status, 'cannot be changed') if org_status_changed? && org_status_was == 'accepted'
  end

  def deleted_lawyer_cannot_be_updated
    return unless lawyer_status_was == 'deleted' && lawyer_status == 'deleted'

    errors.add(:base, 'cannot be updated')
  end
end
