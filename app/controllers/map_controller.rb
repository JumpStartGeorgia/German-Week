class MapController < ApplicationController
	protect_from_forgery 
	
	def index
		gon.map_page = true
		gon.tile_url = 'http://tile.mapspot.ge/en/{z}/{x}/{y}.png'
		gon.map_id = 'map_map_page'
		gon.attribution = 'Map data &copy; <a href="http://jumpstart.ge" target="_blank">JumpStart Georgia</a>'
		gon.lat = 41.699504919895
		gon.lon = 44.797002757205
		
		respond_to do |format|
			format.html
		end
		
	end
		
end
