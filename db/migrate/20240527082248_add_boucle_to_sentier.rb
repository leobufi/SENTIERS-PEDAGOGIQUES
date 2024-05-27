class AddBoucleToSentier < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :is_boucle, :boolean
  end
end
