class Api::V1::AccountHistoryRecord < ApplicationRecord
  include PrettyId
  self.table_name = 'account_histories'
  self.id_prefix = 'acc_hist'
  belongs_to :user, class_name: 'Api::V1::UserRecord'

  validates :action, :ip, :time, presence: true

  enum :action, { log_in: 0, refresh_token: 1, logout: 2, block: 3, updated_user: 4, registered: 5 }
end
