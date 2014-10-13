class AddLastInputToProgressions < ActiveRecord::Migration
  def change
    add_column :progressions, :last_input, :text
  end
end
