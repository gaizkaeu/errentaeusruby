module Api::V1::Services
  class AuthenticateUserService
    def call(email, password, ip)
      record = Api::V1::UserRecord.find_by!(email:)
      user = Api::V1::User.new(record.attributes.symbolize_keys!)
      if record.authenticate(password)
        UserPubSub.publish('user.logged_in', user_id: record.id, ip:, provider: 'email', action: 0)
        [user, true]
      else
        [user, false]
      end
    end
  end
end
