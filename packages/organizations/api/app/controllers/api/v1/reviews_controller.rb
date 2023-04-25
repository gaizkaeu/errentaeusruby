# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :authenticate

      def create
        review = Services::OrgCreateReviewService.new.call(current_user, review_params)
        if review.errors.empty?
          render json: Serializers::ReviewSerializer.new(review, serializer_config), status: :created
        else
          render json: review.errors, status: :unprocessable_entity
        end
      end

      private

      def serializer_config
        if current_user
          ReviewPolicy.new(current_user, nil).serializer_config
        else
          {}
        end
      end

      def review_params
        params.require(:review).permit(:rating, :comment, :organization_id).merge!(user_id: current_user.id)
      end
    end
  end
end
