module Api::V1::Services
  class RefreshUserService
    def call(user_id, ip)
      record = Api::V1::UserRecord.find(user_id)
      raise ActiveRecord::RecordNotFound unless record
      return false if record.blocked?

      UserPubSub.publish('user.refresh_token', user_id: record.id, ip:, action: 1)
      true
    end
  end
end
