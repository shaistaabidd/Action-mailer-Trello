class ChangeUnitAmountTypeFromStringToInteger < ActiveRecord::Migration[6.1]
  def change
    remove_column :prices, :unit_amount
    add_column :prices, :unit_amount, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email") :prices, :unit_amount, :integer
  end
end
