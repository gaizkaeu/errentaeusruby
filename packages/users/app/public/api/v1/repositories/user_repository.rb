class Api::V1::Repositories::UserRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[name client_first_name lawyer_first_name].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      Api::V1::User.new(record.attributes.symbolize_keys!.merge({ email: record.account&.email, password?: record.account&.password_hash.present?, status: record.account&.status }))
    end
  end

  def self.query_base
    Api::V1::UserRecord.includes(:account)
  end
end
