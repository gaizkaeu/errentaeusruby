class Api::V1::OrganizationManage::StatsController < ApiBaseController
  before_action :authenticate
  before_action :set_organization

  def index
    org_stats = Api::V1::Repositories::OrganizationStatRepository.filter(filtering_params)
    render json: Api::V1::Serializers::OrganizationStatSerializer.new(org_stats)
  end

  private

  def set_organization
    org_id = params.require(:organization_manage_id)
    @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
    authorize @org, :manage?
  end

  def filtering_params
    params.slice(*Api::V1::Repositories::OrganizationStatRepository::FILTER_KEYS).merge!(organization_id: @org_id)
  end
end
