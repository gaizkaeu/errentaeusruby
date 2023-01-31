class Api::V1::OrganizationSubscriptionController < ApiBaseController
  before_action :authenticate
  before_action :set_organization
  before_action -> { authorize @organization, :manage? }

  def create
    session = Api::V1::Services::OrgCreateCheckoutSession.new.call(current_user, create_subscription_params.merge!(id: @organization.id), raise_error: false)

    render json: { url: session.url }
  end

  def retrieve
    subscription = Stripe::Subscription.retrieve(@organization.subscription_id)

    render json: subscription
  end

  private

  def set_organization
    @organization = Api::V1::Repositories::OrganizationRepository.find(params[:organization_manage_id])
  end

  def serializer_config
    { params: { manage: true } }
  end

  def create_subscription_params
    params.slice(:plan_id, :return_url)
  end
end
