class ChangeSponsors < ActiveRecord::Migration
  def up
      # remove sponsors table and add sponsor fields to event_sponsors
      add_column :event_sponsors, :name, :string
      add_column :event_sponsors, :logo_path, :string
      add_column :event_sponsors, :url, :string
      remove_column :event_sponsors, :sponsor_id
      drop_table :sponsor_translations
      drop_table :sponsors
  end

  def down
    remove_column :event_sponsors, :name, :string
    remove_column :event_sponsors, :logo_path, :string
    remove_column :event_sponsors, :url, :string
    add_column :event_sponsors, :sponsor_id
    create_table :sponsors do |t|
      t.string :title
      t.text :description
      t.string :type
      t.string :url
      t.string :phone
      t.string :address

      t.timestamps
    end
    Sponsor.create_translation_table! :title => :string, :description => :text, :address => :string
  end
end
