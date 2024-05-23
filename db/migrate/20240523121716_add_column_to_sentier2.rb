class AddColumnToSentier2 < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :color, :string
  end
end
