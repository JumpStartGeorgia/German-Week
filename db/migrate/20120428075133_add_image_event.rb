class AddImageEvent < ActiveRecord::Migration
  def up
    change_table :events do |t|
       t.has_attached_file :picture
    end
    add_column :event_translations, :picture_text, :string
  end

  def down
    drop_attached_file :events, :picture
    drop_column :event_translations, :picture_text
  end
end
