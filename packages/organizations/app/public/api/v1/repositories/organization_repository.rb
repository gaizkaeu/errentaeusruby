class Api::V1::Repositories::OrganizationRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[coordinates location_name name price_range].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      if record.logo.attached?
        Api::V1::Organization.new(record.attributes.symbolize_keys!.merge({ logo: Rails.application.routes.url_helpers.rails_blob_url(record.logo) }))
      else
        Api::V1::Organization.new(record.attributes.symbolize_keys!)
      end
    end
  end

  def self.query_base
    Api::V1::OrganizationRecord.with_attached_logo
  end
end
