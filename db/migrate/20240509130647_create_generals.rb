class CreateGenerals < ActiveRecord::Migration[7.1]
  def change
    create_table :generals do |t|
      t.text :general_pres
      t.string :home_img

      t.timestamps
    end
  end
end
