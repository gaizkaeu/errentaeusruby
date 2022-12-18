module Api::V1::Services
  class FindTaxService
    include Authorization

    def call(current_account, id)
      tax_record =
        if current_account.lawyer?
          Api::V1::TaxIncomeRecord.where(lawyer_id: current_account.id).find(id)
        else
          Api::V1::TaxIncomeRecord.where(client_id: current_account.id).find(id)
        end
      raise ActiveRecord::RecordNotFound unless tax_record

      tax = Api::V1::TaxIncome.new(tax_record.attributes.symbolize_keys!)
      authorize_with current_account, tax, :show?
      tax
    end
  end
end
