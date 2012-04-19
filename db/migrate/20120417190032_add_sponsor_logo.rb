class AddSponsorLogo < ActiveRecord::Migration
  def up
    change_table :sponsors do |t|
       t.has_attached_file :logo
    end
  end

  def down
    drop_attached_file :sponsors, :logo
  end
end
