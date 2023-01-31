class Api::V1::Services::OrgCreateCheckoutSession < ApplicationService
  include Authorization

  def call(current_account, params, raise_error: false)
    organization = Api::V1::Repositories::OrganizationRepository.find(params[:id])
    authorize_with current_account, organization, :manage_subscription?

    raise Pundit::NotAuthorizedError if can_create_checkout_session?(organization) && raise_error

    session(params[:return_url], current_account.stripe_customer_id, params[:price_id], organization.id)
  end

  private

  def can_create_checkout_session?(organization)
    organization.subscription_id.nil? && organization.status == :not_subscribed
  end

  # rubocop:disable Metrics/MethodLength
  def session(return_url, customer_id, price_id, org_id)
    Stripe::Checkout::Session.create(
      {
        success_url: "#{Rails.application.config.x.frontend_app}#{return_url}?session_id={CHECKOUT_SESSION_ID}",
        mode: 'subscription',
        customer: customer_id,
        metadata: { type: 'org_payment_intent', id: org_id },
        subscription_data: {
          metadata: { type: 'org_payment_intent', id: org_id }
        },
        line_items: [
          {
            quantity: 1,
            price: price_id
          }
        ]
      }
    )
  end
  # rubocop:enable Metrics/MethodLength
end
