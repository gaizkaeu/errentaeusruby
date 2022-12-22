module Api::V1::Services
  class UpdateUserService
    include Authorization

    def call(current_account, id, params, raise_error: false)
      update_method = raise_error ? :update! : :update

      user_record = Api::V1::UserRecord.find(id)
      user = Api::V1::User.new(user_record.attributes.symbolize_keys!)

      raise ActiveRecord::RecordNotFound unless user

      authorize_with current_account, user, :update?

      user_record.public_send(update_method, params).tap do |res|
        return false unless res

        UserPubSub.publish('user.updated', user_id: user.id, action: 4)
      end

      true
    end
  end
end
