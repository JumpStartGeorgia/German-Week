class CreateEventTranslations < ActiveRecord::Migration
  def change
    create_table :event_translations do |t|
      t.integer :event_id
      t.string :locale
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
