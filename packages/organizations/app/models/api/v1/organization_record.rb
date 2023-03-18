class Api::V1::OrganizationRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  def self.ransackable_attributes(_auth_object = nil)
    %w[name phone website description email]
  end

  acts_as_taggable_on :services

  PRICES_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_prices.json')
  private_constant :PRICES_JSON_SCHEMA

  SETTINGS_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_settings.json')
  private_constant :SETTINGS_JSON_SCHEMA

  self.table_name = 'organizations'
  self.id_prefix = 'org'

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  enum status: { not_subscribed: 0, featured_city: 1, featured_province: 2, featured_country: 3 }

  scope :filter_by_name, ->(name) { where('name ILIKE ?', "%#{name}%") }
  scope :filter_by_phone, ->(phone) { where('phone ILIKE ?', "%#{phone}%") }
  scope :filter_by_website, ->(website) { where('website ILIKE ?', "%#{website}%") }
  scope :filter_by_featured, ->(featured) { where(featured:) }
  scope :filter_by_description, ->(description) { where('description ILIKE ?', "%#{description}%") }
  scope :filter_by_email, ->(email) { where('email ILIKE ?', "%#{email}%") }
  scope :filter_by_owner_id, ->(owner_id) { where(owner_id:) }
  scope :filter_by_prices, ->(prices) { where('prices @> ?', prices.to_json) }
  scope :filter_by_coordinates, ->(coordinates) { near([coordinates[:latitude], coordinates[:longitude]]) }
  scope :filter_by_bounds, ->(bounds) { within_bounding_box([bounds[:south], bounds[:west]], [bounds[:north], bounds[:east]]) }
  scope :filter_by_price_range, ->(price_range) { where('price_range <= ?', price_range) }

  validates :name, presence: true, length: { maximum: 30, minimum: 4 }
  validates :phone, presence: true, length: { maximum: 10, minimum: 9 }
  validates :website, presence: true, length: { maximum: 50, minimum: 4 }
  validates :description, presence: true, length: { maximum: 1000, minimum: 4 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  validates :prices, json: { schema: PRICES_JSON_SCHEMA }
  validates :settings, json: { schema: SETTINGS_JSON_SCHEMA }

  has_many :memberships, class_name: 'Api::V1::OrganizationMembershipRecord', dependent: :destroy, foreign_key: :organization_id
  has_many :users, through: :memberships, class_name: 'Api::V1::UserRecord'
  has_many :invitations, class_name: 'Api::V1::OrganizationInvitationRecord', dependent: :destroy, foreign_key: :organization_id
  has_many :lawyer_profiles, class_name: 'Api::V1::LawyerProfileRecord', through: :memberships

  has_one_attached :logo

  after_validation :calculate_price_range
  after_validation :geocode unless Rails.env.test?

  def calculate_price_range
    price_r = 0
    prices.values.map(&:to_i).each do |price|
      price_r += price
    end
    self.price_range = price_r
  end

  def address
    [street, postal_code, city, province, country].compact.join(', ')
  end

  def lawyers_active
    Api::V1::LawyerProfileRecord.where(organization_id: id, lawyer_status: 'on_duty').count
  end

  def lawyers_inactive
    Api::V1::LawyerProfileRecord.where(organization_id: id, lawyer_status: 'off_duty').count
  end
end
