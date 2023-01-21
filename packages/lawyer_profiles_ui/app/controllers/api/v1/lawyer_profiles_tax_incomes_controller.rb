module Api
  module V1
    class LawyerProfilesTaxIncomesController < ::ApiBaseController
      before_action :authenticate
      before_action :set_lawyer_profile

      def index
        authorize @lawyer_profile, :index_tax_incomes?
        tax_incomes = Api::V1::Repositories::TaxIncomeRepository.filter(filtering_params.merge!(lawyer_id: @lawyer_profile.id))
        render json: Api::V1::Serializers::TaxIncomeSerializer.new(tax_incomes)
      end

      private

      def set_lawyer_profile
        @lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find(params[:lawyer_profile_id])
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::TaxIncomeRepository::FILTER_KEYS)
      end
    end
  end
end
