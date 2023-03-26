class Api::V1::OrganizationManage::LawyerProfilesController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    profiles = Api::V1::LawyerProfile.joins(:organization_memberships)
                                     .where(organization_memberships: { organization: @organization })
                                     .includes(:user, :taggings)

    render json: Api::V1::Serializers::LawyerProfileSerializer.new(profiles, serializer_config)
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
