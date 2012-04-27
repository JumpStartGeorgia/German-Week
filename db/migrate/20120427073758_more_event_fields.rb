class MoreEventFields < ActiveRecord::Migration
  def change
		add_column :events, :url2, :string
		add_column :events, :building_name, :string
  end
end
