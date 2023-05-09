class AddDeadlineDateToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :deadline, :datetime
  end
end
