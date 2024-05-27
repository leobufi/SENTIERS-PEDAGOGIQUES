class AddBooleansToSentier < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :is_theme, :boolean, default: false, null: false
    add_column :sentiers, :is_boucle, :boolean, default: false, null: false
  end
end
