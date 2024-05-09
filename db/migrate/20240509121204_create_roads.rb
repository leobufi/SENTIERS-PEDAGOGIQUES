class CreateRoads < ActiveRecord::Migration[7.1]
  def change
    create_table :roads do |t|
      t.references :sentier, null: false, foreign_key: true
      t.references :point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
