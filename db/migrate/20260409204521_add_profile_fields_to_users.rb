class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :text
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :is_verified, :boolean, default: false, null: false
  end
end
