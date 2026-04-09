class CreatePropertyOwnerships < ActiveRecord::Migration[8.1]
  def change
    create_table :property_ownerships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :ownership_type
      t.date :started_on
      t.date :ended_on

      t.timestamps
    end
  end
end
