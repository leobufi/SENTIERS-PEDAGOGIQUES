class CreateWaypoints < ActiveRecord::Migration[7.1]
  def change
    create_table :waypoints do |t|
      t.references :sentier, null: false, foreign_key: true
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.decimal :position, precision: 10, scale: 2

      t.timestamps
    end
  end
end
