class CreateCards < ActiveRecord::Migration[6.1]
  def up
    create_table :cards do |t|
      t.string "name"
      t.string "status"
      t.timestamps
    end
  end
  def down
    drop_table :cards
  end
end
