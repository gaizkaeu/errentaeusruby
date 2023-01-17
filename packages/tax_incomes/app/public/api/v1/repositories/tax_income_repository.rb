class Api::V1::Repositories::TaxIncomeRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[client_id].freeze
  public_constant :FILTER_KEYS

  def self.query_base
    Api::V1::TaxIncome.includes(:appointment)
  end

  def self.map_record(record)
    super(record) do
      record
    end
  end

  def self.model_name
    'Api::V1::TaxIncome'.constantize
  end
end
