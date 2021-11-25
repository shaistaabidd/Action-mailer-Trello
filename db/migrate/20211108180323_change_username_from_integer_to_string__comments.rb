class ChangeUsernameFromIntegerToStringComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :user_name, :string
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
