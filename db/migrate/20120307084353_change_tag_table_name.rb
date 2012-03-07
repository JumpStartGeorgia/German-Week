class ChangeTagTableName < ActiveRecord::Migration
  def change
      rename_table :tags, :categories
      rename_table :event_tags, :event_categories
      rename_table :tag_translations, :category_translations
  end 
end
