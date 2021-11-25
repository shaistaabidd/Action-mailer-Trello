class AddStripeProductIdAndStripePriceIdToPricesTable < ActiveRecord::Migration[6.1]
  def change
    add_column :prices, :stripe_product_id, :string
    add_column :prices, :stripe_price_id, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
