# frozen_string_literal: true

module Api
  module V1
    class Organizations::ReviewsController < ::ApiBaseController
      before_action :authenticate, except: :index

      def index
        reviews = Api::V1::Repositories::ReviewRepository.filter(filtering_params)
        render json: Api::V1::Serializers::ReviewSerializer.new(reviews)
      end

      private

      def filtering_params
        org_id = params.require(:organization_id)
        params.slice(*Api::V1::Repositories::ReviewRepository::FILTER_KEYS).merge!(organization_id: org_id)
      end
    end
  end
end
