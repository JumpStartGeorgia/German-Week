class MapController < ApplicationController
	protect_from_forgery 
	def index
		respond_to do |format|
			format.html
		end
	end
	
end
