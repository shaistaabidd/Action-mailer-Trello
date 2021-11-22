class PricesController < ApplicationController
  def new
    @price = Price.new

  end

  def create
    @price=Price.new(price_params)
    @price.product_id=params[:id]
    if @price.save
      flash[:notice]="Price Save Successfully!!"
      redirect_to boards_path
    else
      flash[:notice]="Invalid.. Try Again!!"
      render('new')
    end
  end
  

  private

  def price_params
    params.required(:price).permit(:unit_amount,:recurring_interval)
  end

end
