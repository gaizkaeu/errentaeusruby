class Api::V1::Repositories::OrganizationRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[coordinates location_name name price_range featured].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      if record.logo.attached?
        Api::V1::Organization.new(record.attributes.symbolize_keys!.merge({ logo: record.logo&.url }))
      else
        Api::V1::Organization.new(record.attributes.symbolize_keys!)
      end
    end
  end

  def self.query_base
    if block_given?
      yield model_name
    else
      model_name.with_attached_logo
    end
  end
end
