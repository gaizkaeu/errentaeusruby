module Api::V1::Services
  class IndexTaxService
    def call(current_account)
      tax_record =
        if current_account.lawyer?
          Api::V1::TaxIncomeRecord.where(lawyer_id: current_account.id)
        else
          Api::V1::TaxIncomeRecord.where(client_id: current_account.id)
        end
      raise ActiveRecord::RecordNotFound unless tax_record

      tax_record.map do |tax|
        Api::V1::TaxIncome.new(tax.attributes.symbolize_keys!)
      end
    end
  end
end
