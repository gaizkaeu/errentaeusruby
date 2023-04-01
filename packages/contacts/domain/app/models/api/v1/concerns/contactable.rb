module Api::V1::Concerns::Contactable
  extend ActiveSupport::Concern

  included do
    belongs_to :organization, class_name: 'Api::V1::Organization'
    belongs_to :user, class_name: 'Api::V1::User', optional: true
  end

  def first_name
    user&.first_name || attributes['first_name']
  end

  def last_name
    user&.last_name || attributes['last_name']
  end
end
