class RemovePriceColumnFromPrices < ActiveRecord::Migration[6.1]
  def change
    remove_column :prices, :price
  end
end
