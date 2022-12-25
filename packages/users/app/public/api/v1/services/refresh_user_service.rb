class Api::V1::Services::RefreshUserService < ApplicationService
  def call(user_id, ip)
    record = Api::V1::UserRecord.find(user_id)
    raise ActiveRecord::RecordNotFound unless record
    return false if record.blocked?

    UserPubSub.publish('user.refresh_token', user_id: record.id, ip:, time: Time.now.iso8601.to_s, action: 1)
    true
  end
end
