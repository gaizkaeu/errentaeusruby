# frozen_string_literal: true

class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate

  def create
    review = Api::V1::Services::OrgCreateReviewService.new.call(current_user, review_params)
    if review.errors.empty?
      render json: Api::V1::Serializers::ReviewSerializer.new(review, serializer_config), status: :created
    else
      render json: review.errors, status: :unprocessable_entity
    end
  end

  private

  def serializer_config
    if current_user
      Api::V1::ReviewPolicy.new(current_user, nil).serializer_config
    else
      {}
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :organization_id).merge!(user_id: current_user.id)
  end
end
