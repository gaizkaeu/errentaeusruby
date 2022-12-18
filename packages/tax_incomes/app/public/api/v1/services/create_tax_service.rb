module Api::V1::Services
  class CreateTaxService
    include Authorization

    def call(current_account, tax_income_params)
      tax_record = Api::V1::TaxIncomeRecord.new(tax_income_params)
      tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
      authorize_with current_account, tax, :create?
      # rubocop:disable Rails/SaveBang
      tax_record.save
      # rubocop:enable Rails/SaveBang
      tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
      tax.instance_variable_set(:@errors, tax_record.errors)
      tax
    end
  end
end
