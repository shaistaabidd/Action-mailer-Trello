class ChangeColumnTypeOfCard < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :status
    add_column :cards, :status, :integer
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
