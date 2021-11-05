class ChangeColumnTypeFromIntegerToStringOfCard < ActiveRecord::Migration[6.1]
  def change
    change_column :cards, :status, :string
  end
end
