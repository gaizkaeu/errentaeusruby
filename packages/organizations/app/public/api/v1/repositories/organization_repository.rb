class Api::V1::Repositories::OrganizationRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[coordinates location_name name price_range featured bounds].freeze
  public_constant :FILTER_KEYS


  def self.map_record(record)
    super(record) do
      Api::V1::Organization.new(record.attributes.symbolize_keys!.merge(skill_list: record.skill_list))
    end
  end

  def self.query_base
    if block_given?
      yield model_name
    else
      model_name
    end
  end
end
