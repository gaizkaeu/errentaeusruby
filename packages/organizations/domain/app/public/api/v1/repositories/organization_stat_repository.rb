class Api::V1::Repositories::OrganizationStatRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[organization_id date_start date_end].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      Api::V1::OrganizationStat.new(record.attributes.symbolize_keys!)
    end
  end

  def self.query_base
    super.order(date: :asc)
  end
end
