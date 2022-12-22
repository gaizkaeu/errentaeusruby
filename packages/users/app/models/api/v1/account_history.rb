class Api::V1::AccountHistory < ApplicationRecord
  belongs_to :user

  enum :action, { log_in: 0, refresh_token: 1, logout: 2 }
end
