module Api::V1::TaxIncomeRepository
  module_function

  def find_by!(**kargs)
    Api::V1::TaxIncomeRecord.find_by!(**kargs)
    Api::V1::TaxIncome.new(tax_record.id, tax_record.lawyer_id, tax_record.client_id, tax_record.status, tax_record.price)
  end

  def add(user)
    tax_record = Api::V1::TaxIncome.create!(user.to_hash)
    tax = Api::V1::TaxIncome.new(tax_record.id, tax_record.lawyer_id, tax_record.client_id, tax_record.status, tax_record.price)
    tax.instance_variable_set(:@errors, tax_record.errors)
    tax
  end

  def count
    Api::V1::TaxIncomeRecord.count
  end
end
