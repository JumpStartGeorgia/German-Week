class CreateTagTranslations < ActiveRecord::Migration
  def change
    create_table :tag_translations do |t|
      t.integer :tag_id
      t.string :locale
      t.string :title

      t.timestamps
    end
  end
end
