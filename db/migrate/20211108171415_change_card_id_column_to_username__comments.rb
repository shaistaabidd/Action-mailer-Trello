class ChangeCardIdColumnToUsernameComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :user_id, :user_name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
