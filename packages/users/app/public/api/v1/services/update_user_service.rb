class Api::V1::Services::UpdateUserService
  include Authorization

  def call(current_account, id, params, raise_error: false)
    update_method = raise_error ? :update! : :update

    user_record = Api::V1::UserRecord.find(id)
    user = Api::V1::User.new(user_record.attributes.symbolize_keys!)

    raise ActiveRecord::RecordNotFound unless user

    authorize_with current_account, user, :update?

    user_record.public_send(update_method, params)

    user = Api::V1::User.new(user_record.attributes.symbolize_keys!)
    user.instance_variable_set(:@errors, user_record.errors)
    user
  end
end
