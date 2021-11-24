class SuccessController < ApplicationController
  def index
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end
end
