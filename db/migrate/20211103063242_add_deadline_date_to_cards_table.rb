class AddDeadlineDateToCardsTable < ActiveRecord::Migration[6.1]
  def change
    change_column :cards, :deadline, :date
  end
end
