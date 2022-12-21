module Api::V1::Services
  class FindTaxService
    include Authorization

    def call(current_account, id)
      tax_record =
        if current_account.lawyer?
          Api::V1::TaxIncome.where(lawyer_id: current_account.id).find(id)
        else
          Api::V1::TaxIncome.where(client_id: current_account.id).find(id)
        end
      raise ActiveRecord::RecordNotFound unless tax_record

      authorize_with current_account, tax_record, :show?
      tax_record
    end
  end
end
