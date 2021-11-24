class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      success_url: "http://127.0.0.1:3000/success/index?session_id={CHECKOUT_SESSION_ID}",
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
    flash[:notice]="Thanks #{Stripe::Customer.retrieve(@session.customer).email} for your subscription for #{@session.amount_total}"
  end
end
