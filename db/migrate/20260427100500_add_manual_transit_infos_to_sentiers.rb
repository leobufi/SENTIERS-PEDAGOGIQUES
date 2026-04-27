class AddManualTransitInfosToSentiers < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :manual_duration, :string
    add_column :sentiers, :manual_distance, :string
  end
end
