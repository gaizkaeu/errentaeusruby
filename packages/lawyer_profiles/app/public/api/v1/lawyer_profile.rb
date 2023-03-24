class Api::V1::LawyerProfile
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :organization_id, :first_name, :last_name, :email, :user_id, :avatar_url, :on_duty, :skills

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @user_id = attributes.fetch(:user_id)
    @on_duty = attributes.fetch(:on_duty, 'on_duty')
    @first_name = attributes.fetch(:first_name, nil)
    @last_name = attributes.fetch(:last_name, nil)
    @avatar_url = attributes.fetch(:avatar_url, nil)
    @skills = attributes.fetch(:skills, [])
  end

  def persisted?
    !!id
  end

  def lawyer_id
    @user_id
  end

  def lawyer
    @lawyer ||= Api::V1::Repositories::UserRepository.find(user_id)
  end

  def ==(other)
    id == other.id
  end
end
