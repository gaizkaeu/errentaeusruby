# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ::ApiBaseController
      before_action :authenticate

      def index
        reviews = Api::V1::Repositories::ReviewRepository.filter(filtering_params)
        render json: Api::V1::Serializers::ReviewSerializer.new(reviews)
      end

      def create
        review = Api::V1::Services::OrgCreateReviewService.new.call(current_user, review_params)
        if review.errors.empty?
          render json: Api::V1::Serializers::ReviewSerializer.new(review), status: :created
        else
          render json: review.errors, status: :unprocessable_entity
        end
      end

      private

      def review_params
        params.require(:review).permit(:rating, :comment, :organization_id).merge!(user_id: current_user.id)
      end

      def filtering_params
        params.require(:organization_id)
        params.slice(*Api::V1::Repositories::ReviewRepository::FILTER_KEYS)
      end
    end
  end
end
