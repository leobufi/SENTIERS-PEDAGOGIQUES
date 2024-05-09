class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.string :title
      t.text :infos
      t.float :lat
      t.float :long
      t.string :video
      t.string :audio

      t.timestamps
    end
  end
end
