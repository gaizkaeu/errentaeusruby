class Api::V1::AccountHistory
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :account_id, :message, :at, :metadata

  def initialize(attributes = {})
    @id = attributes[:id]
    @account_id = attributes[:account_id]
    @message = attributes[:message]
    @at = attributes[:at]
    @metadata = attributes[:metadata]
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id
  end
end
