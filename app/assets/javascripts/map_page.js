
$(function(){
	
	if (gon.map_page ){
	var addMarkers = function(){
			
	};

	$("a.event_menu_day_link").click(function(){		
		$.getJSON("",function(data){
			addMarkers(data);
		});
		return false;
	});
	
	var map1 = new L.Map(gon.map_big_id);
			map1.addLayer(gon.tile_url).setView(new L.LatLng(gon.lat, gon.lon), gon.zoom);
	
	}
});
