class CreateEventSponsors < ActiveRecord::Migration
  def change
    create_table :event_sponsors do |t|
      t.integer :event_id
      t.integer :sponsor_id

      t.timestamps
    end
  end
end
