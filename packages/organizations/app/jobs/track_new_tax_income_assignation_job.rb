# rubocop:disable Rails/SkipsModelValidations
class TrackNewTaxIncomeAssignationJob < ApplicationJob
  def perform(params)
    Api::V1::OrganizationRecord.find(params['organization_id']).increment!(:tax_income_count)
  end
end
# rubocop:enable Rails/SkipsModelValidations
