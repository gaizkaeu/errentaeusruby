class Api::V1::OrganizationMembership
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :organization_id, :user_id, :role, :first_name, :last_name

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @organization_id = attributes.fetch(:organization_id, nil)
    @user_id = attributes.fetch(:user_id, nil)
    @role = attributes.fetch(:role, nil)
    @first_name = attributes.fetch(:first_name, nil)
    @last_name = attributes.fetch(:last_name, nil)
  end

  def admin?
    role == 'admin'
  end

  def deleted?
    role == 'deleted'
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id
  end
end
