class CreateJoinTableImageQuestion < ActiveRecord::Migration
  def change
    create_join_table :images, :questions do |t|
      t.index [:image_id, :question_id]
      t.index [:question_id, :image_id]
    end
  end
end
