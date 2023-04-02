class Api::V1::Organization < ApplicationRecord
  include PrettyId
  ORGANIZATION_SUBSCRIPTION_STATUS = %w[not_subscribed featured_city featured_state featured_country].freeze

  self.id_prefix = 'org'

  def self.ransackable_attributes(_auth_object = nil)
    %w[name phone website description email]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['skills']
  end

  def self.ransackable_scopes(_auth_object = nil)
    %w[coordinates bounds near_by]
  end

  PRICES_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_prices.json')
  private_constant :PRICES_JSON_SCHEMA

  SETTINGS_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_settings.json')
  private_constant :SETTINGS_JSON_SCHEMA

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  public_constant :ORGANIZATION_SUBSCRIPTION_STATUS

  scope :coordinates, ->(coords) { near(coords.split(',')) }
  scope :bounds, ->(bounds) { within_bounding_box(bounds.split(',')) }
  scope :near_by, ->(loc) { near(loc) }

  # VALIDATIONS
  validates :name, presence: true, length: { maximum: 30, minimum: 4 }
  validates :phone, presence: true, length: { maximum: 10, minimum: 9 }
  validates :website, presence: true, length: { maximum: 50, minimum: 4 }
  validates :description, presence: true, length: { maximum: 1000, minimum: 4 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :prices, json: { schema: PRICES_JSON_SCHEMA }
  validates :settings, json: { schema: SETTINGS_JSON_SCHEMA }
  validates :status, inclusion: { in: ORGANIZATION_SUBSCRIPTION_STATUS }

  # RELATIONS
  has_many :memberships, class_name: 'Api::V1::OrganizationMembership', dependent: :destroy
  has_many :users, through: :memberships, class_name: 'Api::V1::User'
  has_many :invitations, class_name: 'Api::V1::OrganizationInvitation', dependent: :destroy
  has_one_attached :logo

  acts_as_taggable_on :skills

  after_validation :geocode unless Rails.env.test?

  after_update_commit do
    OrganizationPubSub.publish('organization.updated', id:)
    Api::V1::Services::OrgPlaceIdService.call(id)
  end

  after_create_commit do
    OrganizationPubSub.publish('organization.created', id:)
    Api::V1::Services::OrgPlaceIdService.call(id)
  end

  # GEOCODING

  def address
    [street, postal_code, city, province, country].compact.join(', ')
  end

  def address_with_name
    [name, address].compact.join(', ')
  end

  # MEMBERSHIPS

  def user_is_admin?(user_id)
    memberships.where(user_id:, role: 'admin').any?
  end

  def user_is_member?(user_id)
    memberships.where(user_id:).any?
  end

  def max_members
    5
  end

  # SKILLS

  def skill_list_name
    skills.pluck(:name)
  end

  # Google Places details

  def google_place_details
    return {} if google_place_id.blank? || !google_place_verified

    Rails.cache.fetch("google_place_details_#{google_place_id}", expires_in: 1.day) do
      GooglePlaces::Client.new(ENV.fetch('GOOGLE_API_KEY', nil)).spot(google_place_id, fields: 'reviews,rating', language: 'es').json_result_object
    end
  end
end
