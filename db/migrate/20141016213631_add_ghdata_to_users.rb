class AddGhdataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :text
    add_column :users, :username, :string
  end
end
