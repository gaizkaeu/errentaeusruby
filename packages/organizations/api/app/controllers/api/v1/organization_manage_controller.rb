class Api::V1::OrganizationManageController < ApiBaseController
  before_action :authenticate
  before_action :set_organization, except: %i[create index]

  def index
    orgs = Api::V1::Organization
           .joins(:memberships)
           .where(organization_memberships: { user_id: current_user.id })
           .where.not(organization_memberships: { role: 'deleted' })

    render json: Api::V1::Serializers::OrganizationSerializer.new(orgs, serializer_config)
  end

  def show
    render json: Api::V1::Serializers::OrganizationSerializer.new(@organization, serializer_config)
  end

  def create
    organization = Api::V1::Services::OrgCreateService.new.call(current_user, organization_params)

    if organization.errors.empty?
      render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :created, location: organization
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  def update
    organization = Api::V1::Organization.update(@organization.id, organization_params)
    if organization.errors.empty?
      render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :ok
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  private

  def set_organization
    @organization = Api::V1::Organization.find_by!(id: params[:id])

    raise Pundit::NotAuthorizedError unless @organization.user_is_admin?(current_user.id)
  end

  def organization_params
    params.require(:organization_manage).permit(:name, :description, :website, :email, :phone, :city, :postal_code, :street, :province, :street, :prices, :logo, :visible, settings: {})
  end

  def serializer_config
    { params: { manage: true } }
  end
end
