class Api::V1::OrganizationManageController < ApiBaseController
  before_action :authenticate
  before_action :set_organization, except: %i[create index]
  before_action -> { authorize @organization, :manage? }, except: %i[create index]

  def index
    authorize Api::V1::Organization, :manage_index?
    organizations =
      Api::V1::Repositories::OrganizationRepository.filter(filtering_params) do |query|
        query.all.limit(25).order(status: :desc, created_at: :desc)
      end

    render json: Api::V1::Serializers::OrganizationSerializer.new(organizations, serializer_config)
  end

  def show
    render json: Api::V1::Serializers::OrganizationSerializer.new(@organization, serializer_config)
  end

  def create
    organization = Api::V1::Services::OrgCreateService.new.call(current_user, organization_params)

    if organization.persisted?
      render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :created, location: organization
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  def update
    organization = Api::V1::Services::OrgUpdateService.new.call(current_user, params[:id], organization_params, raise_error: false)
    if organization.errors.empty?
      render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :ok
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  private

  def set_organization
    @organization = Api::V1::Repositories::OrganizationRepository.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def organization_params
    policy = Api::V1::OrganizationPolicy.new(current_user, Api::V1::Organization)
    params.require(:organization_manage).permit(:name, :description, :owner_id, :website, :email, :phone, :city, :postal_code, :street, :province, :street, :prices, :logo, :visible).merge!(policy.forced_create_params)
  end

  def serializer_config
    { params: { manage: true } }
  end

  def filtering_params
    policy = Api::V1::OrganizationPolicy.new(current_user, Api::V1::Organization)
    params.slice(policy.permitted_filter_params_manage).merge!(policy.filter_forced_params_manage)
  end
end
