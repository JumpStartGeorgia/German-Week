class AddSponsorTypes < ActiveRecord::Migration
  def up
    create_table :sponsor_types do |t|

      t.timestamps
    end
    SponsorType.create_translation_table! :title => :string
    add_column :sponsors, :sponsor_type_id, :int
  end

  def down
    drop_table :sponsor_types
    SponsorTypes.drop_translation_table!    
    drop_column :sponsors, :sponsor_type_id
  end
end
