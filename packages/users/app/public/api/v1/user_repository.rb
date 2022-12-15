module Api::V1::UserRepository
  module_function

  def find_by!(**kargs)
    record = Api::V1::UserRecord.find_by!(**kargs)
    Api::V1::User.new(record.id, record.first_name, record.last_name, record.email)
  end

  def add(user)
    user_record = Api::V1::UserRecord.create!(user.to_hash)
    user = Api::V1::User.new(user_record.id, user_record.first_name, user_record.last_name, user_record.email, user_record.account_type)
    user.instance_variable_set(:@errors, user_record.errors)
    user
  end

  def from_omniauth(params)
    Api::V1::UserRecord.from_omniauth(params)
  end

  def authenticate_user(email, password)
    record = Api::V1::UserRecord.find_by!(email:)
    [record, record.authenticate(password)]
  end
end
