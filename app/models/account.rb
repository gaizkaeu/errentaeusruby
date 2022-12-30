class Account < ApplicationRecord
  include Rodauth::Rails.model
  has_one :user, dependent: :destroy, class_name: 'Api::V1::UserRecord'
  enum :status, unverified: 1, verified: 2, closed: 3
end
