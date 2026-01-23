class AddRichTextToPoint < ActiveRecord::Migration[7.1]
  def change
    add_column :points, :bibliography, :text
    add_column :points, :pdf, :string
  end
end
