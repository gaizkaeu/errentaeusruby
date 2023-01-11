module Api::V1::UserRepository
  def self.find_by!(**kargs)
    record = Api::V1::UserRecord.find_by!(**kargs)
    Api::V1::User.new(record.attributes.symbolize_keys!)
  end

  def self.find(id)
    record = Api::V1::UserRecord.includes(:account).find(id)
    Api::V1::User.new(record.attributes.symbolize_keys!.merge(email: record.account.email, password?: record.account.password_hash.present?, confirmed?: record.account.status == 'verified'))
  end

  def self.where(**kargs)
    Api::V1::UserRecord.where(**kargs).map do |u|
      map_record(u)
    end
  end

  def self.filter(filters = {})
    users = Api::V1::UserRecord.filter(filters, Api::V1::UserRecord.includes(:account).all.limit(20))
    users.map do |u|
      map_record(u)
    end
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

  def self.map_record(record)
    Api::V1::User.new(record.attributes.symbolize_keys!.merge(email: record.account.email, password?: record.account.password_hash.present?, confirmed?: record.account.status == 'verified'))
  end
end
