class Api::V1::OrganizationLawyersController < ApiBaseController
  before_action :authenticate
  before_action :set_organization
  before_action -> { authorize @organization, :manage? }

  def index
    lawyers = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params.merge!(organization_id: params[:organization_manage_id]))
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyers, serializer_config)
  end

  def show
    lawyer = Api::V1::Repositories::LawyerProfileRepository.find(params[:id])
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer, serializer_config)
  end

  def accept
    lawyer = Api::V1::Services::LawProfAcceptService.new.call(current_user, params[:organization_manage_id], params[:id])
    if lawyer.errors.empty?
      render json: { success: 'Lawyer accepted' }, status: :ok
    else
      render json: lawyer.errors, status: :unprocessable_entity
    end
  end

  def remove
    lawyer = Api::V1::Services::LawProfRejectService.new.call(current_user, params[:organization_manage_id], params[:id])
    if lawyer.errors.empty?
      render json: { success: 'Lawyer rejected' }, status: :ok
    else
      render json: lawyer.errors, status: :unprocessable_entity
    end
  end

  private

  def set_organization
    @organization = Api::V1::Repositories::OrganizationRepository.find(params[:organization_manage_id])
  end

  def serializer_config
    { params: { manage: true } }
  end

  def filtering_params
    params.slice(*Api::V1::Repositories::LawyerProfileRepository::FILTER_KEYS)
  end
end
