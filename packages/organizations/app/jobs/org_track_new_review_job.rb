class OrgTrackNewReviewJob < ApplicationJob
  COUNT_HASH = { 1 => :one_star_count, 2 => :two_star_count, 3 => :three_star_count, 4 => :four_star_count, 5 => :five_star_count }.freeze

  private_constant :COUNT_HASH

  def perform(params)
    count_column = COUNT_HASH[params['rating']]
    ActiveRecord::Base.transaction do
      org = Api::V1::OrganizationRecord.find(params['organization_id'])
      org.increment(count_column)
      org.update!(avg_rating: Api::V1::Services::RevCalculateRatingService.call(org_stat))
      org_stat = Api::V1::OrganizationStatRecord.where(organization_id: params['organization_id'], date: params['date']).first_or_create!
      org_stat.increment(count_column)
      org_stat.update!(avg_rating_today: Api::V1::Services::RevCalculateRatingService.call(org_stat))
    end
  end
end
