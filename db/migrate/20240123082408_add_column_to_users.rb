class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role_id, :integer
    add_column :users, :avatar, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :name, :string
  end
end
