class Api::V1::User
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :first_name, :last_name, :email, :account_type, :confirmed_at, :blocked, :uid, :stripe_customer_id, :provider

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @email = attributes.fetch(:email)
    @account_type = attributes.fetch(:account_type)
    @confirmed_at = attributes.fetch(:confirmed_at)
    @blocked = attributes.fetch(:blocked)
    @provider = attributes.fetch(:provider)
    @stripe_customer_id = attributes.fetch(:stripe_customer_id)
    @uid = attributes.fetch(:uid)
  end

  def persisted?
    !!id
  end

  def lawyer?
    @account_type == 'lawyer'
  end

  def client?
    @account_type == 'client'
  end

  def confirmed?
    !@confirmed_at.nil?
  end

  def ==(other)
    id == other.id && first_name == other.first_name
  end
end
