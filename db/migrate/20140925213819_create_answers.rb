class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_given
      t.belongs_to :user
      t.belongs_to :question

      t.timestamps null: false
    end
  end
end
