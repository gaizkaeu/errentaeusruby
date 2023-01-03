class Api::V1::Services::CreateUserService < ApplicationService
  def call(user, _ip = '0.0.0.0', raise_error: false)
    create_method = raise_error ? :create! : :create
    record = Api::V1::UserRecord.public_send(create_method, user)
    user = Api::V1::User.new(record.attributes.symbolize_keys!)
    user.instance_variable_set(:@errors, record.errors)
    user
  end
end
