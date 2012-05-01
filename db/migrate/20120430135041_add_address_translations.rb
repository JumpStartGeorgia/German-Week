class AddAddressTranslations < ActiveRecord::Migration
  def change
		#rename old fields, but not delete (so we do not lose data)
		rename_column :events, :building_name, :building_name_old
		rename_column :events, :address, :address_old
		rename_column :sponsors, :address, :address_old

		# create new fields
		add_column :event_translations, :building_name, :string
		add_column :event_translations, :address, :string
		add_column :sponsor_translations, :address, :string

		# now move the existing addresses to the translations table
		Event.all.each do |event|
			event.event_translations.each do |et|
				if et.locale == 'de'
					et.building_name = event.building_name_old
					et.address = event.address_old
					break
				end
			end
			event.save
		end

		Sponsor.all.each do |sponsor|
			sponsor.sponsor_translations.each do |st|
				if st.locale == 'de'
					st.address = sponsor.address_old
				end
			end
			sponsor.save
		end

  end
end
