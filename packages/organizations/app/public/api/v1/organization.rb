class Api::V1::Organization
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :name, :location, :phone, :email, :website, :description, :owner_id

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name)
    @location = attributes.fetch(:location)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @website = attributes.fetch(:website)
    @description = attributes.fetch(:description, nil)
    @owner_id = attributes.fetch(:owner_id, false)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && first_name == other.first_name
  end
end
