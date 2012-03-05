class CreateSponsorTranslations < ActiveRecord::Migration
  def change
    create_table :sponsor_translations do |t|
      t.integer :sponsor_id
      t.string :locale
      t.string :title
      t.text :description
      t.string :address

      t.timestamps
    end
  end
end
