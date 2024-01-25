class CreateTableProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :address
      t.string :name
      t.string :phone
      t.boolean :is_admin
      t.boolean :gender
      t.timestamps
    end
  end
end
