class ChangeEventsTable < ActiveRecord::Migration
  def up
      # change columns so date and time for start and end are in same column
      rename_column :events, :start_time, :start
      change_column :events, :start, :datetime
      rename_column :events, :end_time, :end
      change_column :events, :end, :datetime
      remove_column :events, :event_date
  end

  def down
      rename_column :events, :start, :start_time
      change_column :events, :start_time, :time
      rename_column :events, :end, :end_time
      change_column :events, :end_time, :time
      add_column :events, :event_date, :date
  end
end
