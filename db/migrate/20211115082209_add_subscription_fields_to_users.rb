class AddSubscriptionFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :plan, :string
    add_column :users, :subscription_status, :string, default:  "incomplete"
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
