class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :title
      t.text :description
      t.string :type
      t.string :url
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
