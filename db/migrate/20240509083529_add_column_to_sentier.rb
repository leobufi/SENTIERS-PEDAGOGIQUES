class AddColumnToSentier < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :description, :text
  end
end
