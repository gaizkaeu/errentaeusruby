class Api::V1::Repositories::OrganizationRequestRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[name].freeze
  public_constant :FILTER_KEYS
end
