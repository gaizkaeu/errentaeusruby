class Api::V1::Repositories::TransactionRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[organization_id date_start date_end user_id].freeze
  public_constant :FILTER_KEYS

  def self.query_base
    super.order(created_at: :asc)
  end
end
