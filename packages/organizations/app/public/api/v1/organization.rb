class Api::V1::Organization
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :name, :phone, :email, :website, :description, :owner_id, :prices, :logo, :created_at, :location, :price_range, :tax_income_count, :ratings

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
    @location = {
      latitude: attributes.fetch(:latitude, nil),
      longitude: attributes.fetch(:longitude, nil),
      city: attributes.fetch(:location, nil)
    }
    @ratings = {
      one_star_count: attributes.fetch(:one_star_count, 0),
      two_star_count: attributes.fetch(:two_star_count, 0),
      three_star_count: attributes.fetch(:three_star_count, 0),
      four_star_count: attributes.fetch(:four_star_count, 0),
      five_star_count: attributes.fetch(:five_star_count, 0)
    }
    @price_range = attributes.fetch(:price_range, nil)
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
