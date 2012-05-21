var map;
$(function(){

	if (gon.map_page && gon.show_map){
			
		map = new L.Map(gon.map_id);				
				map.addLayer(new L.TileLayer(gon.tile_url,{
					attribution: gon.attribution
				})).setView(new L.LatLng(gon.lat, gon.lon), gon.zoom);				
					 
		Array.prototype.__ = function(text){
			this.push(text);
		};
		
		$.each([$("#event-day"),$("#event-category")],function(index,value){
			value.change(function(){
				if ($("#event-day").val().length != 0 &&
						$("#event-category").val().length != 0)
				{
					window.location = "/"+gon.locale+"/map/daycategory/"+$("#event-category").val()+"/"+$("#event-day").val();
				}
				else if ($("#event-day").val().length != 0 &&
								 $("#event-category").val().length == 0){
					window.location = "/"+gon.locale+"/map/day/"+$("#event-day").val();
				}
				else if ($("#event-day").val().length == 0 &&
								 $("#event-category").val().length != 0){
					window.location = "/"+gon.locale+"/map/category/"+$("#event-category").val();	 
				}
				else{
					window.location = "/"+gon.locale+"/map";
				}
			});
		});

		
		if ( (gon.event_lats.length !== 0 || 
					gon.event_lons.length !== 0) &&
				gon.event_lats.length == gon.event_lons.length)
		{
			var marker = null, event_latlng = null, marker_popups = new Array, i = 0;
			$.each(gon.event_lats,function(index,value){
			
					event_latlng = new L.LatLng(gon.event_lats[index],gon.event_lons[index]);
					marker = new L.Marker(event_latlng);
					map.addLayer(marker);
											
					var popup_content = new Array;						
							popup_content.__("<a href=\""+gon.event_paths[index]+"\"><center><font class=\"event-popup-title\">"+gon.event_popups[index]+"</font></center></a>");					
							popup_content.__("<center>");
							popup_content.__("<font class=\"event-popup-start\">"+gon.event_starts[index]+"</font>");
							if (gon.event_ends[index].length > 0){
								popup_content.__(" - ");
								popup_content.__("<font class=\"event-popup-end\">"+gon.event_ends[index]+"</font>");							
							}
							popup_content.__("</center>");
							popup_content.__("<center>");
							popup_content.__("<font class=\"event-popup-location\">"+gon.event_locations[index]+"</font>");
							popup_content.__("</center>");

					
							popup_content.__("<br />");			
							popup_content.__("<center>");
							popup_content.__("<font class=\"event-popup-description\">"+gon.event_descriptions[index]+"</font>");
							popup_content.__("</center>");
							popup_content.__("<br />");
					
					
					//map.addLayer(marker.bindPopup(popup_content[0])._popup.setLatLng(event_latlng));
					marker.bindPopup(popup_content.join(''));
					/*var default_popup_zindex = 10, old_marker_zindex = null;					
					
					
					/*$(marker).mouseenter(function(e){											
						var target_popup = e.target._popup;				
						old_marker_zindex = $(e.target._icon).css('z-index');														
						$(e.target._icon).css('z-index', 9999);
						$(target_popup._container).css('z-index', 9999);
						target_popup.setContent(popup_content.join(''));
					}).mouseleave(function(e){
						var target_popup = e.target._popup;
						$(e.target._icon).css('z-index', old_marker_zindex);
						$(target_popup._container).css('z-index', default_popup_zindex);
						target_popup.setContent(popup_content[0]);
					});
										
					
					//var index = i++;
					//$(".leaflet-marker-pane").children("img:last").attr('id','marker_'+index);
					//marker_popups.push(marker._popup);										
					//$(marker._popup._container).attr("index", index);
										
					//var last_popup = $(".leaflet-popup-pane").children("div.leaflet-popup:last")
					
					/*last_popup.mouseenter(function(){
						var target = marker_popups[$(last_popup).attr('index')];
						old_marker_zindex = $("#marker_"+$(last_popup).attr('index')).css('z-index');						
						$("#marker_"+$(last_popup).attr('index')).css('z-index', 9999);
						$(last_popup).css('z-index', 9999);
						target.setContent(popup_content.join(''));						
					}).mouseleave(function(){
						var target = marker_popups[$(last_popup).attr('index')];
						$("#marker_"+$(last_popup).attr('index')).css('z-index', old_marker_zindex);
						$(last_popup).css('z-index', default_popup_zindex);
						target.setContent(popup_content[0]);
					});*/
					
					
			});	
						
			// get lat/long of all markers to set bounds
			var latlngs = [];
		  for (var k in map._layers) {
				if (typeof(map._layers[k]._latlng) !== 'undefined')
				{
			    latlngs.push(map._layers[k]._latlng);
				}
			}
			if (latlngs.length == 0){
				// no marker bounds found, use default				
				map.setView(new L.LatLng(gon.event_lats[gon.event_lats.length-1], gon.event_lons[gon.event_lons.length-1]),12);
			} else {
				// set bounds on markers
				map.fitBounds(new L.LatLngBounds(latlngs));
			}
		}
		else if(gon.events_day_exists){
			var no_events_div = new Array;
					no_events_div.__("<div class=\"no-events-overlay\">");						
					no_events_div.__("</div>");
					no_events_div.__("<div class=\"no-events-msgbox\">");
							no_events_div.__("<center>");
								no_events_div.__("<p>");
									no_events_div.__(I18n.t("app.msgs.map_no_events"));									
								no_events_div.__("</p>");
								no_events_div.__("<button id=\"no-events-button\">");
									no_events_div.__("<strong>Ok</strong>");
								no_events_div.__("</button>");
							no_events_div.__("</center>");
						no_events_div.__("</div>");
			$("#map_container").append(no_events_div.join(''));
			$("#no-events-button").click(function(){
				$("#map_container").children("div").slice(1).each(function(){
					$(this).fadeOut(500,function(){
						$(this).remove();
					});
				});
			});
		}
		
					 		
	}
});
