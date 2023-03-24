class Api::V1::Services::TaxAssignLawyerService < ApplicationService
  include Authorization

  # rubocop:disable Metrics/AbcSize
  def call(tax_income_id)
    tax = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    raise ActiveRecord::RecordNotFound unless tax

    lawyer = Api::V1::Repositories::LawyerProfileRepository.where(organization_id: tax.organization_id, lawyer_status: :on_duty, org_status: :accepted).first
    return unless lawyer

    tax.lawyer_id = lawyer.id
    tax.save!

    TaxIncomePubSub.publish('tax_income.lawyer_assigned', tax_income_id: tax.id, lawyer_id: lawyer.id)
    OrganizationPubSub.publish('organization.tax_income_assigned', organization_id: lawyer.organization_id, date: Time.zone.today.to_s)
    LawyerPubSub.publish('lawyer.tax_income_assigned', lawyer_id: lawyer.id)

    tax
  end
  # rubocop:enable Metrics/AbcSize
end
