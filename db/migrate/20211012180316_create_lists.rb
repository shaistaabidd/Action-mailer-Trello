class CreateLists < ActiveRecord::Migration[6.1]
  def up
    create_table :lists do |t|
      t.string "name"
      t.timestamps
    end
  end
  def down
    drop_table :lists
  end
end
