class Api::V1::Appointment
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :time, :status, :created_at, :updated_at, :phone, :tax_income_id, :lawyer_id, :client_id, :meeting_method

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @time = attributes.fetch(:time, nil)
    @client_id = attributes.fetch(:client_id)
    @lawyer_id = attributes.fetch(:lawyer_id)
    @created_at = attributes.fetch(:created_at, nil)
    @updated_at = attributes.fetch(:updated_at, nil)
    @phone = attributes.fetch(:phone, '')
    @tax_income_id = attributes.fetch(:tax_income_id, nil)
    @meeting_method = attributes.fetch(:meeting_method)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && start_time == other.start_time
  end
end
