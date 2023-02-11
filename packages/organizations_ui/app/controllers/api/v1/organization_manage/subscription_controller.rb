class Api::V1::OrganizationManage::SubscriptionController < ApiBaseController
  before_action :authenticate
  before_action :set_organization

  def create
    session = Api::V1::Services::OrgCreateCheckoutSession.new.call(current_user, create_subscription_params.merge!(id: @org.id), raise_error: false)

    render json: { url: session.url }
  end

  def retrieve
    subscription = Stripe::Subscription.retrieve(@org.subscription_id)

    render json: subscription
  end

  private

  def set_organization
    org_id = params.require(:organization_manage_id)
    @org = Api::V1::Repositories::OrganizationRepository.find(org_id)
    authorize @org, :manage?
  end

  def serializer_config
    { params: { manage: true } }
  end

  def create_subscription_params
    params.slice(:plan_id, :return_url, :price_id)
  end
end
