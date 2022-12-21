module Api::V1::Services
  class UpdateTaxService
    include Authorization

    def call(current_account, tax_income, params, raise_error: false)
      update_method = raise_error ? :update! : :update

      authorize_with current_account, tax_income, :update?
      tax_record = Api::V1::TaxIncome.find(tax_income.id)
      tax_record.public_send(update_method, params)

      tax_record
    end
  end
end
