class RemoveOldSponsorFields < ActiveRecord::Migration
  def up
    remove_column :sponsors, :phone
    remove_column :sponsors, :type
    remove_column :sponsor_translations, :address
  end

  def down
    add_column :sponsors, :phone, :string
    add_column :sponsors, :type, :string
    add_column :sponsor_translations, :address, :string
  end
end
