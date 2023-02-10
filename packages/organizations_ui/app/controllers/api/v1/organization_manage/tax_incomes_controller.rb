module Api
  module V1
    class OrganizationManage::TaxIncomesController < ::ApiBaseController
      before_action :authenticate
      before_action :set_organization

      def index
        tax_incomes = Api::V1::Repositories::TaxIncomeRepository.filter(filtering_params)
        render json: Api::V1::Serializers::TaxIncomeSerializer.new(tax_incomes).serializable_hash
      end

      private

      def set_organization
        org_id = params.require(:organization_manage_id)
        @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
        authorize @org, :manage?
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::TaxIncomeRepository::FILTER_KEYS).merge!(organization_id: @org.id)
      end
    end
  end
end
