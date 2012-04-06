
$(function(){
	console.log(gon);
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
			var marker = null;
			$.each(gon.event_lats,function(index,value){
					marker = new L.Marker(new L.LatLng(gon.event_lats[index],gon.event_lons[index]));
					map.addLayer(marker);
						
					var popup = new Array;						
					popup.__("<a href=\""+gon.event_paths[index]+"\"><center><font style=\"font-weight:bold;font-size:15px;\">"+gon.event_popups[index]+"</font></center></a>");					
					popup.__("<center>");
					popup.__("<font style=\"font-weight:bold;font-size:10px;\">"+gon.event_starts[index]+"</font>");
					popup.__(" - ");
					popup.__("<font style=\"font-weight:bold;font-size:10px;\">"+gon.event_ends[index]+"</font>");		
					popup.__("</center>");
					popup.__("<br />");			
					popup.__("<center>");
					popup.__("<font style=\"font-size:13px;\">"+gon.event_descriptions[index]+"</font>");
					popup.__("</center>");
					popup.__("<br />");
					marker.bindPopup(popup.join('')).openPopup();
			});
			map.setView(new L.LatLng(gon.event_lats[gon.event_lats.length-1], gon.event_lons[gon.event_lons.length-1]),11);
		}
		else if(gon.events_day_exists){
			var no_events_div = new Array;
					no_events_div.__("<div style=\"position:absolute;width:100%;height:100%;left:0px;top:0px;background:#000;opacity:0.4;filter:alpha(opacity=40);\">");						
					no_events_div.__("</div>");
					no_events_div.__("<div style=\"position:absolute;left:40%;top:20%;width:270px;height:130px;background:#000;-webkit-border-radius: 10px;-moz-border-radius: 10px;border-radius: 10px;opacity:0.70;\">");
							no_events_div.__("<center>");
								no_events_div.__("<p style=\"color:#FFF;margin-top:30px;font-size:17px;\">");
									no_events_div.__("No events for these day!!!");
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
