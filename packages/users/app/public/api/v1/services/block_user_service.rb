class Api::V1::Services::BlockUserService < ApplicationService
  include Authorization

  def call(current_account, id, raise_error: false)
    update_method = raise_error ? :block! : :block

    user_record = Api::V1::UserRecord.find(id)
    user = Api::V1::User.new(user_record.attributes.symbolize_keys!)

    raise ActiveRecord::RecordNotFound unless user

    authorize_with current_account, user, :block?

    user_record.public_send(update_method).tap do |res|
      return false unless res

      UserPubSub.publish('user.blocked', user_id: user.id, action: 3)
      return true
    end

    false
  end
end
