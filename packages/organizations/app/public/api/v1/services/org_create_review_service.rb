class Api::V1::Services::OrgCreateReviewService < ApplicationService
  include Authorization

  def call(_current_account, review_params, raise_error: false)
    review = Api::V1::Repositories::ReviewRepository.add(review_params, raise_error:)
    if review.persisted?
      OrganizationPubSub.publish('organization.review_created', organization_id: review.organization_id, rating: review.rating, date: Time.zone.today.to_s)
    end
    review
  end
end
