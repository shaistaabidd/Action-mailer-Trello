class BillingPortalController < ApplicationController
  before_action :verify_authenticity_token, except: :create
  def create
    portal_session=Stripe::BillingPortal::Session.create({
    customer: current_user.stripe_customer_id,
    return_url: boards_url,
    })
    redirect_to portal_session.url
  end

end
