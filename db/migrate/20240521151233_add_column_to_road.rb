class AddColumnToRoad < ActiveRecord::Migration[7.1]
  def change
    add_column :roads, :position, :integer
  end
end
