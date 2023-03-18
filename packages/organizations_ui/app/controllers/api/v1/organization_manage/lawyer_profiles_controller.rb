class Api::V1::OrganizationManage::LawyerProfilesController < ApiBaseController
  before_action :authenticate

  def index
    lawyer_profiles = Api::V1::Services::LawProfIndexOrgLawyersService.new.call(current_user, params[:organization_manage_id])
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profiles, serializer_config)
  end

  private

  def serializer_config
    {
      params: {
        org_admin: true
      }
    }
  end
end
