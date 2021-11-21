class ChangeColumnTypeIntOfCard < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :status
    add_column :cards, :status, :integer
  end
end
