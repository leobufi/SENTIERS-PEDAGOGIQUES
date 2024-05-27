class AddAdressesToSentier < ActiveRecord::Migration[7.1]
  def change
    add_column :sentiers, :depart_address, :string, default: "", null: false
    add_column :sentiers, :arrival_address, :string, default: "", null: false
  end
end
