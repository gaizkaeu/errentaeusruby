module Api
  module V1
    class OrganizationManage::LawyerProfilesController < ::ApiBaseController
      before_action :authenticate
      before_action :set_organization

      def index
        lawyer_profiles = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params)
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profiles, serializer_config)
      end

      private

      def serializer_config
        LawyerProfilePolicy.new(current_user, Api::V1::LawyerProfile).serializer_config
      end

      def set_organization
        org_id = params.require(:organization_manage_id)
        @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
        authorize @org, :manage?
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::LawyerProfileRepository::FILTER_KEYS).merge!(organization_id: @org.id)
      end
    end
  end
end
