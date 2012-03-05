class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :event_date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
