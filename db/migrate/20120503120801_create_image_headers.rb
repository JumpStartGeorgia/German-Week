class CreateImageHeaders < ActiveRecord::Migration
  def change
    create_table :image_headers do |t|

      t.timestamps
    end
  end
end
