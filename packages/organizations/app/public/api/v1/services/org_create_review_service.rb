class Api::V1::Services::OrgCreateReviewService < ApplicationService
  include Authorization

  def call(current_account, review_params, raise_error: false)
    organization = Api::V1::Repositories::OrganizationRepository.find(review_params[:organization_id])
    authorize_with current_account, organization, :review?
    Api::V1::Repositories::ReviewRepository.add(review_params, raise_error:)
  end
end
