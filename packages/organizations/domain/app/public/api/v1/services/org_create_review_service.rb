class Api::V1::Services::OrgCreateReviewService < ApplicationService
  include Authorization

  def call(current_account, review_params, raise_error: false)
    save_method = raise_error ? :create! : :create
    authorize_with current_account, Api::V1::Review, :create?

    Api::V1::Review.public_send(save_method, review_params.merge!(user_id: current_account.id)).tap do |review|
      if review.persisted?
        OrganizationPubSub.publish(
          'organization.review_created',
          organization_id: review.organization_id,
          rating: review.rating,
          date: Time.zone.today.to_s
        )
      end
    end
  end
end
