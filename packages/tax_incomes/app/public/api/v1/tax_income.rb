class Api::V1::TaxIncome
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :lawyer_id, :client_id, :status, :price

  def initialize(id, lawyer_id, client_id, status, price)
    @id = id
    @lawyer_id = lawyer_id
    @client_id = client_id
    @status = status
    @price = price
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && first_name == other.first_name
  end
end
