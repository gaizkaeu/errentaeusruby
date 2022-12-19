module Api::V1::TaxIncomeRepository
  def self.count
    Api::V1::TaxIncomeRecord.count
  end

  def self.find(id)
    tax_record = Api::V1::TaxIncomeRecord.find(id)
    Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
  end


  def self.add(tax_income_params)
    tax_record = Api::V1::TaxIncomeRecord.new(tax_income_params)
    tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
    # rubocop:disable Rails/SaveBang
    tax_record.save
    # rubocop:enable Rails/SaveBang
    tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
    tax.instance_variable_set(:@errors, tax_record.errors)
    tax
  end

  def self.last
    record = Api::V1::TaxIncomeRecord.last
    TaxIncome.new(record.attributes.symbolize_keys!) if record
  end
end
