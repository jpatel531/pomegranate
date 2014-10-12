class AddTutorialToProgressions < ActiveRecord::Migration
  def change
    add_reference :progressions, :tutorial, index: true
  end
end
