class Api::V1::Payout
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :amount, :organization_id, :created_at, :date, :status

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @amount = attributes.fetch(:amount, nil)
    @organization_id = attributes.fetch(:organization_id, nil)
    @created_at = attributes.fetch(:created_at, nil)
    @date = attributes.fetch(:date, nil)
    @status = attributes.fetch(:status, nil)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
