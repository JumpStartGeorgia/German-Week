class AddEventFields < ActiveRecord::Migration
  def change
		add_column :events, :phone, :string
		add_column :events, :fax, :string
		add_column :events, :email, :string
		add_column :events, :url, :string
  end
end
