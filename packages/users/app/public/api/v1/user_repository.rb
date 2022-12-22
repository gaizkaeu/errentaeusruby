module Api::V1::UserRepository
  def self.where(**kargs)
    Api::V1::UserRecord.where(**kargs).map do |record|
      Api::V1::User.new(permitted_attributes(record))
    end
  end

  def self.find_by!(**kargs)
    record = Api::V1::UserRecord.find_by!(**kargs)
    Api::V1::User.new(permitted_attributes(record))
  end

  def self.find(id)
    record = Api::V1::UserRecord.find(id)
    Api::V1::User.new(record.attributes.symbolize_keys!)
  end

  def self.add(user)
    record = Api::V1::UserRecord.create!(user.to_hash)
    user = Api::V1::User.new(record.attributes.symbolize_keys!)
    user.instance_variable_set(:@errors, record.errors)
    user
  end

  def self.count
    Api::V1::UserRecord.count
  end

  def self.permitted_attributes(record)
    record.attributes.symbolize_keys!.slice(:id, :first_name, :last_name, :email, :confirmed_at, :account_type)
  end
end
