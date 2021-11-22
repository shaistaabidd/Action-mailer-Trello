class ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)
    if @product.save
      flash[:notice]="Product Saved Successfully!!!"
      redirect_to product_path(@product)
    else
      flash[:notice]="Try Again!!!"
      render('new')
    end
  end
  def show
    @product=Product.find(params[:id])
  end

  private
    
  def product_params
    params.required(:product).permit(:name)
  end 
end
