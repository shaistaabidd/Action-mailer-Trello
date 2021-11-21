class AddListIdToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :list_id, :integer
    add_index :cards, :list_id
  end
end
