# rubocop:disable Rails/SkipsModelValidations
class TrackDeletedReviewJob < ApplicationJob
  def perform(params)
    count_hash = { 1 => :one_star_count, 2 => :two_star_count, 3 => :three_star_count, 4 => :four_star_count, 5 => :five_star_count }
    count_column = count_hash[params['rating']]
    Api::V1::OrganizationRecord.find(params['organization_id']).decrement!(count_column)
  end
end
# rubocop:enable Rails/SkipsModelValidations
