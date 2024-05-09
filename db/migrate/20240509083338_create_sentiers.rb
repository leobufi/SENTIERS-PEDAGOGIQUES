class CreateSentiers < ActiveRecord::Migration[7.1]
  def change
    create_table :sentiers do |t|
      t.string :title
      t.time :duration
      t.string :difficulty
      t.string :image
      t.string :starting_point_lat
      t.string :starting_point_long
      t.string :arrival_point_lat
      t.string :arrival_point_long
      t.boolean :is_theme

      t.timestamps
    end
  end
end
