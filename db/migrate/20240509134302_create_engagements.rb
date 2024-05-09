class CreateEngagements < ActiveRecord::Migration[7.1]
  def change
    create_table :engagements do |t|
      t.text :sensib
      t.text :protec
      t.text :rules
      t.text :partner
      t.string :engagements_img

      t.timestamps
    end
  end
end
