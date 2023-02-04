class Api::V1::Transaction
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :amount, :amount_capturable, :status, :payment_intent_id, :user_id, :organization_id, :metadata, :created_at

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @amount = attributes.fetch(:amount, nil)
    @amount_capturable = attributes.fetch(:amount_capturable, nil)
    @status = attributes.fetch(:status, nil)
    @payment_intent_id = attributes.fetch(:payment_intent_id, nil)
    @user_id = attributes.fetch(:user_id, nil)
    @organization_id = attributes.fetch(:organization_id, nil)
    @metadata = attributes.fetch(:metadata, nil)
    @created_at = attributes.fetch(:created_at, nil)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
