class Api::V1::Review
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :user, :rating, :organization_id, :tax_income_id, :lawyer_profile_id, :comment, :created_at

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @user = { first_name: attributes.fetch(:first_name, nil), last_name: attributes.fetch(:last_name, nil) }
    @rating = attributes.fetch(:rating, nil)
    @organization_id = attributes.fetch(:organization_id, nil)
    @tax_income_id = attributes.fetch(:tax_income_id, nil)
    @lawyer_profile_id = attributes.fetch(:lawyer_profile_id, nil)
    @comment = attributes.fetch(:comment, nil)
    @created_at = attributes.fetch(:created_at, nil)
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
