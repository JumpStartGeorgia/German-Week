class CreateLatLong < ActiveRecord::Migration
  def change
      add_column :events, :lat, :decimal, {:precision => 15, :scale => 12}
      add_column :events, :lon, :decimal, {:precision => 15, :scale => 12} 
      add_column :sponsors, :lat, :decimal, {:precision => 15, :scale => 12}
      add_column :sponsors, :lon, :decimal, {:precision => 15, :scale => 12}
  end 
end
