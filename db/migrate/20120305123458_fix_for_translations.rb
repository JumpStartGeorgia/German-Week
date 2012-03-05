class FixForTranslations < ActiveRecord::Migration
  # remove columns that have text in them for they need to be in the XXX_translations tables
  def up
    remove_column :events, :title
    remove_column :events, :description
    remove_column :sponsors, :title
    remove_column :sponsors, :description
    remove_column :sponsors, :address
    remove_column :tags, :title
  end

  def down
    add_column :events, :title
    add_column :events, :description
    add_column :sponsors, :title
    add_column :sponsors, :description
    add_column :sponsors, :address
    add_column :tags, :title
  end
end
