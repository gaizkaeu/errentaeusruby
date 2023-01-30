# rubocop:disable Rails/SkipsModelValidations
class OrgTrackNewReviewJob < ApplicationJob
  def perform(params)
    count_hash = { 1 => :one_star_count, 2 => :two_star_count, 3 => :three_star_count, 4 => :four_star_count, 5 => :five_star_count }
    count_column = count_hash[params['rating']]
    ActiveRecord::Base.transaction do
      Api::V1::OrganizationRecord.find(params['organization_id']).increment!(count_column)
      Api::V1::OrganizationStatsRecord.where(organization_id: params['organization_id'], date: params['date']).first_or_create!.increment!(count_column)
    end
  end
end
# rubocop:enable Rails/SkipsModelValidations
