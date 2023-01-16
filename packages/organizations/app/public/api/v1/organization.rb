class Api::V1::Organization
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :name, :phone, :email, :website, :description, :owner_id, :prices, :logo, :created_at, :location

  # rubocop:disable Metrics/AbcSize
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
    @location = {
      latitude: attributes.fetch(:latitude, nil),
      longitude: attributes.fetch(:longitude, nil),
      city: attributes.fetch(:location, nil)
    }
  end
  # rubocop:enable Metrics/AbcSize

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
