module Api::V1::UserRepository
  module_function

  def self.find_by!(**kargs)
    record = Api::V1::UserRecord.find_by!(**kargs)
    Api::V1::User.new(record.id, record.first_name, record.last_name, record.email, record.account_type, record.confirmed_at)
  end

  def self.find(id)
    record = Api::V1::UserRecord.find_by(id: id)
    return nil unless record.present?
    user = Api::V1::User.new(record.id, record.first_name, record.last_name, record.email, record.account_type, record.confirmed_at)
    user
  end

  def self.add(user)
    user_record = Api::V1::UserRecord.create!(user.to_hash)
    user = Api::V1::User.new(user_record.id, user_record.first_name, user_record.last_name, user_record.email, user_record.account_type, user_record.confirmed_at)
    user.instance_variable_set(:@errors, user_record.errors)
    user
  end

  def self.from_omniauth(params)
    Api::V1::UserRecord.from_omniauth(params)
  end

  def self.authenticate_user(email, password)
    record = Api::V1::UserRecord.find_by!(email:)
    [record, record.authenticate(password)]
  end

  def self.count
    Api::V1::UserRecord.count
  end
end
