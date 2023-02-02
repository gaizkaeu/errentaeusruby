class Api::V1::Repositories::LawyerProfileRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[organization_id lawyer_status org_status].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      Api::V1::LawyerProfile.new(record.attributes.symbolize_keys!.merge({ first_name: record.user&.first_name, last_name: record.user&.last_name, avatar: record.avatar&.url }))
    end
  end

  def self.query_base
    Api::V1::LawyerProfileRecord.includes(:user, :avatar_attachment)
  end
end
