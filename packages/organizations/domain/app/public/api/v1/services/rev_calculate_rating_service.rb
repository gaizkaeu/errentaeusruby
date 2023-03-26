class Api::V1::Services::RevCalculateRatingService < ApplicationService
  # rubocop:disable Metrics/AbcSize
  def call(reviews)
    total_count = reviews.one_star_count + reviews.two_star_count + reviews.three_star_count + reviews.four_star_count + reviews.five_star_count
    return 0 if total_count.zero?

    total_rating = COUNT_HASH.keys.sum { |key| key * reviews.send(COUNT_HASH[key]) }

    (total_rating.to_f / total_count).round(2)
  end
  # rubocop:enable Metrics/AbcSize
end
