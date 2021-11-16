class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      success_url: boards_url,
      cancel_url: price_index_url,
      payment_method_types: ['card'],
      line_items: [
        {price: params[:price], quantity: 1},
      ],
      mode: 'subscription',
    })
    respond_to do |format|
      format.js
    end
  end
end
