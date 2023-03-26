class Api::V1::Services::UserStripeCusPortalService < ApplicationService
  include Authorization

  def call(current_account)
    return if current_account.stripe_customer_id.blank?

    Stripe::BillingPortal::Session.create!(
      {
        customer: current_user.stripe_customer_id,
        return_url: params[:return_url]
      }
    )
  end
end
