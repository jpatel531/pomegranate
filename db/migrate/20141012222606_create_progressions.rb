class CreateProgressions < ActiveRecord::Migration
  def change
    create_table :progressions do |t|
      t.belongs_to :user, index: true
      t.integer :steps_completed

      t.timestamps
    end
  end
end
