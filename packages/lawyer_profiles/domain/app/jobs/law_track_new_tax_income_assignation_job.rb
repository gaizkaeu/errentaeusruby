# rubocop:disable Rails/SkipsModelValidations
class LawTrackNewTaxIncomeAssignationJob < ApplicationJob
  def perform(params)
    Api::V1::LawyerProfileRecord.find(params['lawyer_id']).increment!(:tax_income_count)
  end
end
# rubocop:enable Rails/SkipsModelValidations
