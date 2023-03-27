class Api::V1::OrganizationManage::SubscriptionsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate
  before_action :set_organization

  def create
    session = Api::V1::Services::OrgCreateCheckoutSession.new.call(current_user, create_subscription_params.merge!(id: @organization.id), raise_error: false)

    render json: { url: session.url }
  end

  def retrieve
    subscription = Stripe::Subscription.retrieve(@organization.subscription_id)

    render json: subscription
  end

  private

  def serializer_config
    { params: { manage: true } }
  end

  def create_subscription_params
    params.slice(:plan_id, :return_url, :price_id)
  end
end
