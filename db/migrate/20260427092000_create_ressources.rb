class CreateRessources < ActiveRecord::Migration[7.1]
  def change
    create_table :ressources do |t|
      t.timestamps
    end
  end
end
