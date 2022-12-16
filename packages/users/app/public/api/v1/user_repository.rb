module Api::V1::UserRepository
  def self.find_by!(**kargs)
    record = Api::V1::UserRecord.find_by!(**kargs)
    Api::V1::User.new(permitted_attributes(record))
  end

  def self.find(id)
    record = Api::V1::UserRecord.find_by(id:)
    return if record.blank?

    Api::V1::User.new(permitted_attributes(record))
  end

  def self.add(user)
    record = Api::V1::UserRecord.create!(user.to_hash)
    user = Api::V1::User.new(permitted_attributes(record))
    user.instance_variable_set(:@errors, record.errors)
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

  def self.permitted_attributes(record)
    record.attributes.symbolize_keys!.slice(:id, :first_name, :last_name, :email, :confirmed_at, :account_type)
  end
end
