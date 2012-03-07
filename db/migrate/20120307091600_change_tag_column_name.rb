class ChangeTagColumnName < ActiveRecord::Migration
  def change
      rename_column :category_translations, :tag_id, :category_id
      rename_column :event_categories, :tag_id, :category_id
  end 
end
