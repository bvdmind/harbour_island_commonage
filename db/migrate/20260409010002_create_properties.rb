class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :commonage_reference
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.text :notes

      t.timestamps
    end
  end
end
