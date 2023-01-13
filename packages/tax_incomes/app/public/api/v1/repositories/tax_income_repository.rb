class Api::V1::Repositories::TaxIncomeRepository < Repositories::RepositoryBase
  def self.map_record(record)
    super(record) do
      record
    end
  end

  def self.model_name
    'Api::V1::TaxIncome'.constantize
  end
end
