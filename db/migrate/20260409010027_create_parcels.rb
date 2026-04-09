class CreateParcels < ActiveRecord::Migration[8.1]
  def change
    create_table :parcels do |t|
      t.references :property, null: false, foreign_key: true
      t.string :name
      t.decimal :center_latitude
      t.decimal :center_longitude
      t.jsonb :polygon_geojson
      t.decimal :area_acres

      t.timestamps
    end
  end
end
