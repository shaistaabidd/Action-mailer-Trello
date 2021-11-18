class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.integer "price"
      t.string "unit_amount"
      t.string "currency", :default =>  "usd"
      t.string "recurring_interval"
      t.timestamps
    end
  end
end
