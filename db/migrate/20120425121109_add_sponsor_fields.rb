class AddSponsorFields < ActiveRecord::Migration
  def change
		add_column :sponsors, :address, :string
		add_column :sponsors, :phone, :string
		add_column :sponsors, :fax, :string
		add_column :sponsors, :email, :string
  end
end
