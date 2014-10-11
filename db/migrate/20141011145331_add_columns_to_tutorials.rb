class AddColumnsToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :title, :string
    add_column :tutorials, :description, :text
  end
end
