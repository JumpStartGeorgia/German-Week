// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
	// load the map
	// gon variables are either loaded in the application controller (default values)
	//  or in the controller loading the map
	// make sure lat and lon exist
	if (gon.lat && gon.lon)
	{ 
		var cloudmadeUrl = gon.tile_url,
			cloudmadeAttribution = gon.attribution,
			cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: gon.max_zoom, attribution: cloudmadeAttribution});


		// clear map box and update map style
		$("#map").empty();
		$("#map").attr("id", "map");

		var map = new L.Map(gon.map_id);
		map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom).addLayer(cloudmade);

		var marker = new L.Marker(new L.LatLng(gon.lat, gon.lon));
		map.addLayer(marker);

		marker.bindPopup(gon.popup).openPopup();
	}
	else 
	{
		// hide the map
		$("#map").empty();
		$("#map").attr("id", "nomap");

	}
});