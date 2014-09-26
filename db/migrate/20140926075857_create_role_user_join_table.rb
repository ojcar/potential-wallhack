class CreateRoleUserJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :roles, :users do |t|
      t.index [:user_id, :role_id]
      t.index [:role_id, :user_id]
    end
  end
end
