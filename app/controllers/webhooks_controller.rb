class WebhooksController < ApplicationController
  before_action :authenticate_user!, except: :create
  before_action :verify_authenticity_token, except: :create

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      #byebug
      session = event.data.object
      #p event.data.object.customer
      @user = User.find_by(stripe_customer_id: session.customer)
      @user.update(subscription_status: 'active')
    when 'customer.subscription.updated', 'customer.subscription.deleted'
      subscription = event.data.object
      @user = User.find_by(stripe_customer_id: subscription.customer)
      @user.update(
        subscription_status: subscription.status,
        plan: subscription.items.data[0].price.lookup_key,
      )
    end

    render json: { message: 'success' }
  end
end
