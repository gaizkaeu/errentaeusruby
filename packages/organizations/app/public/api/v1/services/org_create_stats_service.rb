class Api::V1::Services::OrgCreateStatsService < ApplicationService
  # rubocop:disable Metrics/AbcSize
  def call(organization_id, raise_error: false)
    save_method = raise_error ? :save! : :save

    org = Api::V1::OrganizationRecord.find(organization_id)
    org_stat = Api::V1::OrganizationStatsRecord.find_or_initialize_by(organization_id:)
    org_stat.lawyers_active_count = org.lawyers_active
    org_stat.lawyers_inactive_count = org.lawyers_inactive
    org_stat.tax_income_count_acc = org.tax_income_count
    org_stat.one_star_count_acc = org.one_star_count
    org_stat.two_star_count_acc = org.two_star_count
    org_stat.three_star_count_acc = org.three_star_count
    org_stat.four_star_count_acc = org.four_star_count
    org_stat.five_star_count_acc = org.five_star_count
    org_stat.date = Time.zone.today

    org_stat.public_send(save_method)
  end
  # rubocop:enable Metrics/AbcSize
end
