class RemoveColumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role_id
    remove_column :users, :avatar
    remove_column :users, :phone
    remove_column :users, :address
    remove_column :users, :is_admin
    remove_column :users, :name
  end
end
