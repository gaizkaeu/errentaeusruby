module Api::V1::TaxIncomeRepository
  def self.count
    Api::V1::TaxIncome.count
  end

  def self.find(id)
    Api::V1::TaxIncome.find(id)
  end

  def self.add(tax_income_params)
    tax_record = Api::V1::TaxIncome.new(tax_income_params)
    # rubocop:disable Rails/SaveBang
    tax_record.save
    # rubocop:enable Rails/SaveBang
    tax_record
  end

  def self.last
    Api::V1::TaxIncome.last
  end
end
