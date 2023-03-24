class Api::V1::Organization < ApplicationRecord
  include PrettyId

  self.id_prefix = 'org'

  def self.ransackable_attributes(_auth_object = nil)
    %w[name phone website description email]
  end

  PRICES_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_prices.json')
  private_constant :PRICES_JSON_SCHEMA

  SETTINGS_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_settings.json')
  private_constant :SETTINGS_JSON_SCHEMA

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  ORGANIZATION_SUBSCRIPTION_STATUS = %w[not_subscribed featured_city featured_state featured_country].freeze
  public_constant :ORGANIZATION_SUBSCRIPTION_STATUS

  scope :filter_by_coordinates, ->(coordinates) { near([coordinates[:latitude], coordinates[:longitude]]) }
  scope :filter_by_bounds, ->(bounds) { within_bounding_box([bounds[:south], bounds[:west]], [bounds[:north], bounds[:east]]) }

  # VALIDATIONS
  validates :name, presence: true, length: { maximum: 30, minimum: 4 }
  validates :phone, presence: true, length: { maximum: 10, minimum: 9 }
  validates :website, presence: true, length: { maximum: 50, minimum: 4 }
  validates :description, presence: true, length: { maximum: 1000, minimum: 4 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :prices, json: { schema: PRICES_JSON_SCHEMA }
  validates :settings, json: { schema: SETTINGS_JSON_SCHEMA }
  validates :subscription_status, inclusion: { in: ORGANIZATION_SUBSCRIPTION_STATUS }

  # RELATIONS
  has_many :memberships, class_name: 'Api::V1::OrganizationMembership', dependent: :destroy, foreign_key: :organization_id
  has_many :users, through: :memberships, class_name: 'Api::V1::UserRecord'
  has_many :invitations, class_name: 'Api::V1::OrganizationInvitation', dependent: :destroy, foreign_key: :organization_id
  has_many :lawyer_profiles, class_name: 'Api::V1::LawyerProfileRecord', through: :memberships
  has_one_attached :logo
  acts_as_taggable_on :services

  after_validation :calculate_price_range
  after_validation :geocode unless Rails.env.test?

  def address
    [street, postal_code, city, province, country].compact.join(', ')
  end

  def skill_list
    skills.pluck(:name)
  end

  def user_is_admin?(user_id)
    memberships.where(user_id: user_id, role: 'admin').any?
  end
end
