class Api::V1::OrganizationRequest
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :name, :phone, :email, :website, :city, :province

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @website = attributes.fetch(:website)
    @city = attributes.fetch(:city, nil)
    @province = attributes.fetch(:province, nil)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
