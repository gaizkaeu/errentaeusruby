# frozen_string_literal: true

module Api
  module V1
    class OrganizationManage::PayoutsController < ::ApiBaseController
      before_action :authenticate
      before_action :set_organization

      def index
        transactions = Api::V1::Repositories::PayoutRepository.filter(filtering_params)
        render json: Api::V1::Serializers::PayoutSerializer.new(transactions)
      end

      private

      def set_organization
        org_id = params.require(:organization_manage_id)
        @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
        authorize @org, :manage?
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::PayoutRepository::FILTER_KEYS).merge!(organization_id: @org.id)
      end
    end
  end
end
