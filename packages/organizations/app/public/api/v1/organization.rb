class Api::V1::Organization
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :name, :phone, :email, :website, :description, :owner_id, :prices, :logo, :created_at, :location, :price_range, :tax_income_count, :ratings, :status, :latitude, :longitude, :city, :province, :country, :street, :postal_code, :subscription_id, :app_fee, :distance, :settings, :visible

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @website = attributes.fetch(:website)
    @description = attributes.fetch(:description, nil)
    @owner_id = attributes.fetch(:owner_id, false)
    @logo = attributes.fetch(:logo, nil)
    @created_at = attributes.fetch(:created_at, nil)
    @prices = attributes.fetch(:prices, {})
    @tax_income_count = attributes.fetch(:tax_income_count, 0)
    @status = attributes.fetch(:status, nil)
    @ratings = {
      one_star_count: attributes.fetch(:one_star_count, 0),
      two_star_count: attributes.fetch(:two_star_count, 0),
      three_star_count: attributes.fetch(:three_star_count, 0),
      four_star_count: attributes.fetch(:four_star_count, 0),
      five_star_count: attributes.fetch(:five_star_count, 0)
    }
    @price_range = attributes.fetch(:price_range, nil)
    @latitude = attributes.fetch(:latitude, nil)
    @longitude = attributes.fetch(:longitude, nil)
    @city = attributes.fetch(:city, nil)
    @province = attributes.fetch(:province, nil)
    @country = attributes.fetch(:country, nil)
    @street = attributes.fetch(:street, nil)
    @postal_code = attributes.fetch(:postal_code, nil)
    @subscription_id = attributes.fetch(:subscription_id, nil)
    @distance = attributes.fetch(:distance, nil)
    @app_fee = attributes.fetch(:app_fee, nil)
    @settings = attributes.fetch(:settings, {})
    @visible = attributes.fetch(:visible, nil)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
