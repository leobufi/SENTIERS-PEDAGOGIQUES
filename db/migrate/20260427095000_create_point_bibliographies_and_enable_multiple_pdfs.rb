class CreatePointBibliographiesAndEnableMultiplePdfs < ActiveRecord::Migration[7.1]
  def up
    create_table :point_bibliographies do |t|
      t.references :point, null: false, foreign_key: true
      t.text :ouvrage
      t.timestamps
    end

    execute <<~SQL
      UPDATE active_storage_attachments
      SET name = 'pdfs'
      WHERE record_type = 'Point' AND name = 'pdf';
    SQL
  end

  def down
    execute <<~SQL
      UPDATE active_storage_attachments
      SET name = 'pdf'
      WHERE record_type = 'Point' AND name = 'pdfs';
    SQL

    drop_table :point_bibliographies
  end
end
