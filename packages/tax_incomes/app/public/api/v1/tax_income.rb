class Api::V1::TaxIncome
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_accessor :id, :lawyer_id, :client_id, :state, :price, :created_at, :updated_at, :year, :observations

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @lawyer_id = attributes.fetch(:lawyer_id)
    @client_id = attributes.fetch(:client_id)
    @state = attributes.fetch(:state)
    @price = attributes.fetch(:price)
    @created_at = attributes.fetch(:created_at)
    @updated_at = attributes.fetch(:updated_at)
    @year = attributes.fetch(:year)
    @observations = attributes.fetch(:observations)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && first_name == other.first_name
  end

  def year?
    !year.nil?
  end
end
