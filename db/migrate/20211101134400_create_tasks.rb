class CreateTasks < ActiveRecord::Migration[6.1]
  def up
    create_table :tasks do |t|
      t.string :username
      t.string :task

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
