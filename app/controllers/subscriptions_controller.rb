class SubscriptionsController < ApplicationController
  def create
    Stripe::Customer.create_source(
      current_user.stripe_customer_id,
      {source: params[:stripeToken]},
    )
    s=Stripe::Subscription.create({
      customer: current_user.stripe_customer_id,
      items: [
      {price: Price.find(params[:id]).stripe_price_id},
    ],
})
    redirect_to boards_path
    # s=Stripe::Checkout::Session.create({
    #   customer: current_user.stripe_customer_id,
    #   success_url: boards_url,
    #   cancel_url: boards_url,
    #   payment_method_types: ['card'],
    #   line_items: [
    #     {price: 'price_1JyXTSGx183h7tz1xqFeTw9l', quantity: 1},
    #   ],
    #   mode: 'subscription',
    # })
    # redirect_to s.url

  end
  
  def show
  end
end
