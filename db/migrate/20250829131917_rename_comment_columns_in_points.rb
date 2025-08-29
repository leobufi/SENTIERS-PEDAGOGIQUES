class RenameCommentColumnsInPoints < ActiveRecord::Migration[7.1]
  def change
    (1..10).each do |i|
      rename_column :points, :"image_#{i}_comment", :"image_#{i}_commment"
    end
  end
end
