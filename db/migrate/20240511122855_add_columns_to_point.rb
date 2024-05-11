class AddColumnsToPoint < ActiveRecord::Migration[7.1]
  def change
    add_column :points, :image_1, :string
    add_column :points, :image_1_commment, :text
    add_column :points, :image_2, :string
    add_column :points, :image_2_commment, :text
    add_column :points, :image_3, :string
    add_column :points, :image_3_commment, :text
    add_column :points, :image_4, :string
    add_column :points, :image_4_commment, :text
    add_column :points, :image_5, :string
    add_column :points, :image_5_commment, :text
    add_column :points, :image_6, :string
    add_column :points, :image_6_commment, :text
    add_column :points, :image_7, :string
    add_column :points, :image_7_commment, :text
    add_column :points, :image_8, :string
    add_column :points, :image_8_commment, :text
    add_column :points, :image_9, :string
    add_column :points, :image_9_commment, :text
    add_column :points, :image_10, :string
    add_column :points, :image_10_commment, :text
  end
end
