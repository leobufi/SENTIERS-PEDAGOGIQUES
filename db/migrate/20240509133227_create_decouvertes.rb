class CreateDecouvertes < ActiveRecord::Migration[7.1]
  def change
    create_table :decouvertes do |t|
      t.text :circuit_acc_text
      t.string :circuit_acc_img
      t.text :anim_scol_text
      t.string :anim_scol_img

      t.timestamps
    end
  end
end
