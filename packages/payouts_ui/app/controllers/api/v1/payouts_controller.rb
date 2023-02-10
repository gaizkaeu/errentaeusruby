# frozen_string_literal: true

module Api
  module V1
    class PayoutsController < ::ApiBaseController
      before_action :authenticate
      before_action -> { authorize Api::V1::Payout, :index? }

      def index
        authorize Api::V1::Payout, :index?
        transactions = Api::V1::Repositories::PayoutRepository.filter(filtering_params)
        render json: Api::V1::Serializers::PayoutSerializer.new(transactions)
      end

      private

      def filtering_params
        params.slice(*Api::V1::Repositories::PayoutRepository::FILTER_KEYS)
      end
    end
  end
end
