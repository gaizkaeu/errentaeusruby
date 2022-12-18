module Api::V1::Services
  class UpdateTaxService
    include Authorization

    def call(current_account, tax_income, params)
      authorize_with current_account, tax_income, :update?
      tax_record = Api::V1::TaxIncomeRecord.find(tax_income.id)
      tax_record.update!(params)

      tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
      tax.instance_variable_set(:@errors, tax_record.errors)
      tax
    end
  end
end
