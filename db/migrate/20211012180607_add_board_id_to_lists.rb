class AddBoardIdToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :board_id, :integer
    add_index :lists, :board_id
  end
end
