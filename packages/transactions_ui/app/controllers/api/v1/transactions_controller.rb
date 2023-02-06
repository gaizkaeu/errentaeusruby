# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ::ApiBaseController
      before_action :authenticate

      def index
        authorize Api::V1::Transaction, :index?
        trns = Api::V1::Repositories::TransactionRepository.filter(filtering_params)
        render json: Api::V1::Serializers::TransactionSerializer.new(trns)
      end

      private

      def filtering_params
        policy = Api::V1::TransactionPolicy.new(current_user, Api::V1::Transaction)
        params.slice(*Api::V1::Repositories::TransactionRepository::FILTER_KEYS).merge!(policy.forced_filter_params)
      end
    end
  end
end
