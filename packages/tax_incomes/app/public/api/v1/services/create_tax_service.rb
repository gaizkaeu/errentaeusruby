module Api::V1::Services
  class CreateTaxService
    include Authorization

    def call(current_account, tax_income_params, raise_error: false)
      save_method = raise_error ? :save! : :save
      tax_record = Api::V1::TaxIncome.new(tax_income_params)
      authorize_with current_account, tax_record, :create?
      tax_record.public_send(save_method)
      tax_record
    end
  end
end
