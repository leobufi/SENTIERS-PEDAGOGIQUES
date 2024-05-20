class CreateQrcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :qrcodes do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
