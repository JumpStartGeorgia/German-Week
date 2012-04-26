class MapController < ApplicationController
	protect_from_forgery 
	
	def index
		gon.map_page = true
		gon.tile_url = 'http://tile.mapspot.ge/en/{z}/{x}/{y}.png'
		gon.map_id = 'map_map_page'
		gon.attribution = 'Map data &copy; <a href="http://jumpstart.ge" target="_blank">JumpStart Georgia</a>'
		gon.zoom = 7
		gon.lat = 41.699504919895
		gon.lon = 44.797002757205		
		gon.show_map = true		
		
		
		gon.event_lats = []
		gon.event_lons = []
		gon.event_popups = []
		gon.event_starts = []
		gon.event_ends = []
		gon.event_locations = []
		gon.event_descriptions = []
		gon.event_paths = []
		gon.events_day_exists = false
		gon.only_day = false
		gon.only_category = false
		gon.day_and_category = false
		if !params[:dayorcategory].nil?	
			gon.events_day_exists = true		
			data = []
			data = Event.find_for_map(params[:type], params[:dayorcategory], params[:day])
			if params[:type] == "day"	
				gon.only_day = true		
			elsif params[:type] == "category" 		
				gon.only_category = true
			elsif params[:type] == "daycategory"
				gon.day_and_category = true
			end

			# process data from sql to gon js	
			if !data.nil? && data.length > 0
  			data.each do |event|				
  				if !event.lat.nil?
  					gon.event_lats.push event.lat.to_s
  					gon.event_lons.push event.lon.to_s
  					gon.event_popups.push event.title.to_s
  					gon.event_starts.push event.start.strftime("%d %B %Y %H:%M").to_s
  					gon.event_ends.push event.end.strftime("%d %B %Y %H:%M").to_s
  					gon.event_locations.push event.address.to_s
  					gon.event_paths.push event_path(event).to_s  									
  					begin						
  						if event.description.to_s.length > 100
  							gon.event_descriptions.push event.description.to_s[0..100]+"..."
  						else 							
  								gon.event_descriptions.push event.description.to_s																					
  						end
  					rescue
  						gon.event_descriptions.push ""
  					end
  				end					  		
        end
			end  
			# end process data from	sql to gon js
		
		end	
		
		respond_to do |format|
			format.html
		end
		
	end
	
end
