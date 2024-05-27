class RemoveBoucleFromSentier < ActiveRecord::Migration[7.1]
  def change
    remove_column :sentiers, :is_boucle, :boolean
  end
end
