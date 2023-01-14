class Api::V1::LawyerProfile
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :organization_id, :user_id, :org_status, :lawyer_status

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @user_id = attributes.fetch(:user_id)
    @organization_id = attributes.fetch(:organization_id)
    @org_status = attributes.fetch(:org_status, 'pending')
    @lawyer_status = attributes.fetch(:lawyer_status, 'on_duty')
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id
  end
end
