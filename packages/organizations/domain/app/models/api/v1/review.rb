class Api::V1::Review < ApplicationRecord
  include PrettyId
  include Filterable

  self.table_name = 'reviews'
  self.id_prefix = 'rev'

  scope :filter_by_rating, ->(rating) { where(rating:) }
  scope :filter_by_comment, ->(comment) { where('comment ILIKE ?', "%#{comment}%") }
  scope :filter_by_organization_id, ->(organization_id) { where(organization_id:) }
  scope :filter_by_user_id, ->(user_id) { where(user_id:) }

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 1000, minimum: 4 }
  validates :organization_id, uniqueness: { scope: :user_id }

  belongs_to :organization, class_name: 'Api::V1::Organization'
  belongs_to :user, class_name: 'Api::V1::User'
end
