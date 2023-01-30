# rubocop:disable Rails/SkipsModelValidations
class OrgTrackNewTaxIncomeAssignationJob < ApplicationJob
  def perform(params)
    ActiveRecord::Base.transaction do
      Api::V1::OrganizationRecord.find(params['organization_id']).increment!(:tax_income_count)
      Api::V1::OrganizationStatsRecord.where(organization_id: params['organization_id'], date: params['date']).first_or_create!.increment!(:tax_income_count)
    end
  end
end
# rubocop:enable Rails/SkipsModelValidations
