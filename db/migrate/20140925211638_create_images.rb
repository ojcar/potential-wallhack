class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :location

      t.timestamps null: false
    end

    create_table :questions_images do |t|
      t.belongs_to :question
      t.belongs_to :image
    end
  end
end
