
$(function(){

	if (gon.map_page ){
			
		var map = new L.Map(gon.map_id);				
				map.addLayer(new L.TileLayer(gon.tile_url))
					 .setView(new L.LatLng(gon.lat, gon.lon), gon.zoom);				
					 
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
					popup_content.__("<a href=\""+gon.event_paths[index]+"\"><center><font style=\"font-weight:bold;font-size:15px;\">"+gon.event_popups[index]+"</font></center></a>");					
					popup_content.__("<center>");
					popup_content.__("<font style=\"font-weight:bold;font-size:10px;\">"+gon.event_starts[index]+"</font>");
					popup_content.__(" - ");
					popup_content.__("<font style=\"font-weight:bold;font-size:10px;\">"+gon.event_ends[index]+"</font>");		
					popup_content.__("</center>");
					popup_content.__("<br />");			
					popup_content.__("<center>");
					popup_content.__("<font style=\"font-size:13px;\">"+gon.event_descriptions[index]+"</font>");
					popup_content.__("</center>");
					popup_content.__("<br />");
					
					
					map.addLayer(marker.bindPopup(popup_content[0])._popup.setLatLng(event_latlng));

					var default_popup_zindex = 10, old_marker_zindex = null;					
					
					
					$(marker).mouseenter(function(e){											
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
					
					
					
					var index = i++;
					$(".leaflet-marker-pane").children("img:last").attr('id','marker_'+index);
					marker_popups.push(marker._popup);										
					$(marker._popup._container).attr("index", index);
										
					var last_popup = $(".leaflet-popup-pane").children("div.leaflet-popup:last")
					
					last_popup.mouseenter(function(){
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
					});
					
					
			});	
			
				
			
			
			
			
			
			map.setView(new L.LatLng(gon.event_lats[gon.event_lats.length-1], gon.event_lons[gon.event_lons.length-1]),12);
			
		}
		else if(gon.events_day_exists){
			var no_events_div = new Array;
					no_events_div.__("<div style=\"position:absolute;width:100%;height:100%;left:0px;top:0px;background:#000;opacity:0.4;filter:alpha(opacity=40);\">");						
					no_events_div.__("</div>");
					no_events_div.__("<div style=\"position:absolute;left:40%;top:20%;width:270px;height:130px;background:#000;-webkit-border-radius: 10px;-moz-border-radius: 10px;border-radius: 10px;opacity:0.70;\">");
							no_events_div.__("<center>");
								no_events_div.__("<p style=\"padding-left:5px;padding-right:5px;color:#FFF;margin-top:30px;font-size:17px;\">");
									no_events_div.__("No events for these ");
									if (gon.day_and_category){
										no_events_div.__("day and category");
									}
									else if(gon.only_day){
										no_events_div.__("day");
									}
									else if(gon.only_category){
										no_events_div.__("category");
									}
									no_events_div.__("!!!");
								no_events_div.__("</p>");
								no_events_div.__("<button id=\"no_events_button\" style=\"width:80px;height:20px;margin-top:25px;opacity:10;filter:alpha(opacity=10);-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;-moz-box-shadow: 5px 5px 5px #000;-webkit-box-shadow: 5px 5px 5px #000;box-shadow: 5px 5px 5px #000;\">");
									no_events_div.__("<strong>Ok</strong>");
								no_events_div.__("</button>");
							no_events_div.__("</center>");
						no_events_div.__("</div>");
			$("#map_container").append(no_events_div.join(''));
			$("#no_events_button").click(function(){
				$("#map_container").children("div").slice(1).each(function(){
					$(this).fadeOut(500,function(){
						$(this).remove();
					});
				});
			});
		}
		
		
					 		
	}
});
