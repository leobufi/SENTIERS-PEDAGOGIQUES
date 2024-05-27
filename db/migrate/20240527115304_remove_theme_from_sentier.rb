class RemoveThemeFromSentier < ActiveRecord::Migration[7.1]
  def change
    remove_column :sentiers, :is_theme, :boolean
  end
end
