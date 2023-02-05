# frozen_string_literal: true

module Api
  module V1
    class PayoutsController < ::ApiBaseController
      before_action :authenticate

      def index
        authorize Api::V1::Payout, :index?
        transactions = Api::V1::Repositories::PayoutRepository.filter(filtering_params)
        render json: Api::V1::Serializers::PayoutSerializer.new(transactions)
      end

      private

      def filtering_params
        policy = Api::V1::PayoutPolicy.new(current_user, Api::V1::Payout)
        params.slice(*Api::V1::Repositories::PayoutRepository::FILTER_KEYS).merge!(policy.forced_filter_params)
      end
    end
  end
end
