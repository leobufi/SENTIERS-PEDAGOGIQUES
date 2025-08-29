class RenameCommmentColumnsInPoints < ActiveRecord::Migration[7.1]
  def change
    (1..10).each do |i|
      rename_column :points, :"image_#{i}_commment", :"image_#{i}_comment"
    end
  end
end
