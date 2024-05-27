class RemoveDurationFromSentier < ActiveRecord::Migration[7.1]
  def change
    remove_column :sentiers, :duration, :time
  end
end
