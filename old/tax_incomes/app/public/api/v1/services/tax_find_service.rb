class Api::V1::Services::TaxFindService < ApplicationService
  include Authorization

  def call(current_account, id)
    tax_record = Api::V1::TaxIncome.find(id)
    authorize_with current_account, tax_record, :show?
    tax_record
  end
end
