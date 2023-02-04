class Api::V1::Repositories::PayoutRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[organization_id date_start date_end].freeze
  public_constant :FILTER_KEYS

  def self.query_base
    super.order(created_at: :asc)
  end
end
