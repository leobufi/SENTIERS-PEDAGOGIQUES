class AddColumnToPoints < ActiveRecord::Migration[7.1]
  def change
    add_column :points, :qr_code, :string
  end
end
