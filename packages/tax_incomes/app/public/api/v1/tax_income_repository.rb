module Api::V1::TaxIncomeRepository
  def self.count
    Api::V1::TaxIncomeRecord.count
  end

  def self.last
    record = Api::V1::TaxIncomeRecord.last
    TaxIncome.new(record.attributes.symbolize_keys!) if record
  end
end
