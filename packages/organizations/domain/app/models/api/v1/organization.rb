class Api::V1::Organization < ApplicationRecord
  # WARNING
  # OPEN CLOSE HOURS ARE STORED IN UTC

  include PrettyId
  ORGANIZATION_SUBSCRIPTION_STATUS = %w[not_subscribed featured_city featured_state featured_country].freeze

  self.id_prefix = 'org'

  def self.ransackable_attributes(_auth_object = nil)
    %w[name phone website description email]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['skills, company_targets, services']
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
  acts_as_taggable_on :company_targets
  acts_as_taggable_on :services

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

  # Times
  # rubocop:disable Metrics/AbcSize
  def open?
    return false if open_close_hours.blank?

    day = Time.zone.now.strftime('%A').downcase
    time = Time.zone.now

    today_schedule = open_close_hours[day]

    return false if today_schedule.nil? || today_schedule['open'] == 'closed' || today_schedule['close'] == 'closed'

    time >= open_close_hours[day]['open'] && time <= open_close_hours[day]['close']
  end

  def near_close?
    return false if open_close_hours.blank? || !open?

    day = Time.zone.now.strftime('%A').downcase
    time = 30.minutes.from_now

    return false if open_close_hours[day]['open'] == 'closed' || open_close_hours[day]['close'] == 'closed'

    time >= open_close_hours[day]['close']
  end

  def nearest_open_time
    today = Time.zone.now

    # get the next day that is open
    open_days = open_close_hours.select { |_day, v| v['open'] != 'closed' && v['close'] != 'closed' }

    7.times do |i|
      day = today + i.days
      wday = day.strftime('%A').downcase
      if open_days.fetch(wday, nil).present?
        return day.change(hour: open_days[wday]['open'].split(':').first.to_i, min: open_days[wday]['open'].split(':').last.to_i, offset: '+0000')
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
