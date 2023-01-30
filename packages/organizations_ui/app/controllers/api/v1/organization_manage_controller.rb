class Api::V1::OrganizationManageController < ApiBaseController
  before_action :authenticate
  before_action :set_organization
  before_action -> { authorize @organization, :manage? }

  def accept
    lawyer = Api::V1::Services::LawProfAcceptService.new.call(current_user, params[:organization_id], params[:lawyer_profile_id])
    if lawyer.errors.empty?
      render json: { success: 'Lawyer accepted' }, status: :ok
    else
      render json: lawyer.errors, status: :unprocessable_entity
    end
  end

  def remove
    lawyer = Api::V1::Services::LawProfRejectService.new.call(current_user, params[:organization_id], params[:lawyer_profile_id])
    if lawyer.errors.empty?
      render json: { success: 'Lawyer rejected' }, status: :ok
    else
      render json: lawyer.errors, status: :unprocessable_entity
    end
  end

  # rubocop:disable Rails/SaveBang
  # rubocop:disable Metrics/MethodLength
  def create_subscription
    session = Stripe::Checkout::Session.create(
      {
        success_url: "#{Rails.application.config.x.frontend_app}#{params[:return_url]}?session_id={CHECKOUT_SESSION_ID}",
        mode: 'subscription',
        customer: current_user.stripe_customer_id,
        metadata: { type: 'org_payment_intent', id: @organization.id, subscription_type: 'featured_city' },
        subscription_data: {
          metadata: { type: 'org_payment_intent', id: @organization.id, subscription_type: 'featured_city' }
        },
        line_items: [
          {
            quantity: 1,
            price: 'price_1MVsoAGrlIhNYf6eOtx9sNvE'
          }
        ]
      }
    )

    render json: { url: session.url }
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Rails/SaveBang

  def lawyers
    lawyers = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params.merge!(organization_id: params[:organization_id]))
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyers, serializer_config)
  end

  def lawyer
    lawyer = Api::V1::Repositories::LawyerProfileRepository.find(params[:lawyer_profile_id])
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer, serializer_config)
  end

  def reviews
    reviews = Api::V1::Repositories::ReviewRepository.filter(filtering_params.merge!(organization_id: params[:organization_id]))
    render json: Api::V1::Serializers::ReviewSerializer.new(reviews, serializer_config)
  end

  private

  def set_organization
    @organization = Api::V1::Repositories::OrganizationRepository.find(params[:organization_id])
  end

  def serializer_config
    { params: { manage: true } }
  end

  def filtering_params
    params.slice(Api::V1::Repositories::LawyerProfileRepository::FILTER_KEYS)
  end
end
