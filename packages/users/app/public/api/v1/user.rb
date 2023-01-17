class Api::V1::User
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON

  extend T::Sig

  attr_reader :id, :first_name, :last_name, :account_type, :stripe_customer_id, :account_id, :email, :password, :confirmed

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @account_type = attributes.fetch(:account_type)
    @stripe_customer_id = attributes.fetch(:stripe_customer_id)
    @account_id = attributes.fetch(:account_id)
    @email = attributes.fetch(:email, nil)
    @password = attributes.fetch(:password?, false)
    @confirmed = attributes.fetch(:status, 'unverified') == 'verified'
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

  def ==(other)
    id == other.id && first_name == other.first_name
  end
end
