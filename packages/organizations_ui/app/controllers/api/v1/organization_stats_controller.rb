class Api::V1::OrganizationStatsController < ApiBaseController
  before_action :authenticate
  before_action :set_organization

  def index
    org_stats = Api::V1::Repositories::OrganizationStatRepository.filter(filtering_params.merge!(organization_id: params[:organization_manage_id]))
    render json: Api::V1::Serializers::OrganizationStatSerializer.new(org_stats)
  end

  private

  def set_organization
    @organization = Api::V1::Repositories::OrganizationRepository.find(params[:organization_manage_id])
  end

  def filtering_params
    params.slice(*Api::V1::Repositories::OrganizationStatRepository::FILTER_KEYS)
  end
end
