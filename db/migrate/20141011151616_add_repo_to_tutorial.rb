class AddRepoToTutorial < ActiveRecord::Migration
  def change
    add_column :tutorials, :repo, :string
  end
end
