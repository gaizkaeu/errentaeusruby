class Api::V1::OrganizationInvitation
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :organization_id, :email, :role, :status, :token, :created_at, :updated_at

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @organization_id = attributes.fetch(:organization_id, nil)
    @email = attributes.fetch(:email, nil)
    @role = attributes.fetch(:role, nil)
    @status = attributes.fetch(:status, nil)
    @token = attributes.fetch(:token, nil)
    @created_at = attributes.fetch(:created_at, nil)
    @updated_at = attributes.fetch(:updated_at, nil)
  end

  def expired?
    created_at < 1.week.ago
  end

  def acceptable?(email)
    status == 'pending' && !expired? && self.email == email
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id
  end
end
