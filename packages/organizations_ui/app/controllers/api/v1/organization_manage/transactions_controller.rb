# frozen_string_literal: true

module Api
  module V1
    class OrganizationManage::TransactionsController < ::ApiBaseController
      before_action :authenticate
      before_action :set_organization

      def index
        authorize Api::V1::Transaction, :index?
        trns = Api::V1::Repositories::TransactionRepository.filter(filtering_params)
        render json: Api::V1::Serializers::TransactionSerializer.new(trns)
      end

      private

      def set_organization
        org_id = params.require(:organization_manage_id)
        @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
        authorize @org, :manage?
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::TransactionRepository::FILTER_KEYS).merge!(organization_id: @org.id)
      end
    end
  end
end
