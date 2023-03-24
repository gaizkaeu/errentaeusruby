class Api::V1::Repositories::OrganizationMembershipRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[name].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      Api::V1::OrganizationMembership.new(record.attributes.symbolize_keys!.merge({ first_name: record.user&.first_name, last_name: record.user&.last_name }))
    end
  end

  def self.query_base
    Api::V1::OrganizationMembershipRecord.includes(:user)
  end
end
