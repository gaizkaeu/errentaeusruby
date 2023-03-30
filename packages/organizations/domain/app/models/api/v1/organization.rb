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
  has_many :lawyer_profiles, class_name: 'Api::V1::LawyerProfile', through: :memberships
  has_one_attached :logo

  acts_as_taggable_on :skills

  after_validation :geocode unless Rails.env.test?

  def address
    [street, postal_code, city, province, country].compact.join(', ')
  end

  def user_is_admin?(user_id)
    memberships.where(user_id:, role: 'admin').any?
  end

  def user_is_member?(user_id)
    memberships.where(user_id:).any?
  end

  def verified_tags
    memberships.joins(:skills).where(tags: { name: skills.pluck(:name) }).pluck('tags.name').uniq
  end

  def skill_list_name
    skills.pluck(:name)
  end

  def skills_verified
    Rails.cache.fetch("org_skills_verified_#{id}", expires_in: 1.hour) do
      all_skills = skill_list_name
      verified = verified_tags

      all_skills.map do |skill|
        {
          name: skill,
          verified: verified.include?(skill)
        }
      end
    end
  end
end
