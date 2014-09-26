class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value
      t.integer :correct
      t.integer :total

      t.timestamps null: false
    end
  end
end
