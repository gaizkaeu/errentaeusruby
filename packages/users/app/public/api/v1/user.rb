class Api::V1::User
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :first_name, :last_name, :email, :account_type

  def initialize(id, first_name, last_name, email, account_type, confirmed_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @account_type = account_type
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
    @confirmed_at.nil?
  end

  def ==(other)
    id == other.id && first_name == other.first_name
  end
end
