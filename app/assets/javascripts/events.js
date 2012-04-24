// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
	$('#event_start').datetimepicker({
			dateFormat: 'yy/mm/dd',
			timeFormat: 'hh:mm',
			separator: ' ',
		  onClose: function(dateText, inst) {
		      var endDateTextBox = $('#event_end');
		      if (endDateTextBox.val() != '') {
		          var testStartDate = new Date(dateText);
		          var testEndDate = new Date(endDateTextBox.val());
		          if (testStartDate > testEndDate)
		              endDateTextBox.val(dateText);
		      }
		      else {
		          endDateTextBox.val(dateText);
		      }
		  },
		  onSelect: function (selectedDateTime){
		      var start = $(this).datetimepicker('getDate');
		      $('#event_end').datetimepicker('option', 'minDate', new Date(start.getTime()));
		  }
	});
	$('#event_end').datetimepicker({
			dateFormat: 'yy/mm/dd',
			timeFormat: 'hh:mm',
			separator: ' ',
		  onClose: function(dateText, inst) {
		      var startDateTextBox = $('#event_start');
		      if (startDateTextBox.val() != '') {
		          var testStartDate = new Date(startDateTextBox.val());
		          var testEndDate = new Date(dateText);
		          if (testStartDate > testEndDate)
		              startDateTextBox.val(dateText);
		      }
		      else {
		          startDateTextBox.val(dateText);
		      }
		  },
		  onSelect: function (selectedDateTime){
		      var end = $(this).datetimepicker('getDate');
		      $('#event_start').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
		  }
	});
});

$(function(){
	$("#btn-getaddr").live({
		'click': function(){
			$.post("/"+gon.locale+"/events/getLocation/latlng",{address:$("#event_address").val()},function(data){								
				data = data.split(',');
				if(parseFloat(data[0]) == 0 && parseFloat(data[1]) == 0){				
					$("#event_lat").val("");
					$("#event_lon").val("");
					$("#event_address").val("");
					$("#control-map").show().animate({"opacity":1},1000,function(){						
						var map = null, 
								tile_layer = null,
								marker = null;						
						tile_layer = new L.TileLayer(gon.tile_url, {maxZoom: gon.max_zoom, attribution: gon.attribution});
						map = new L.Map("control-map");
						map._container._leaflet = false;
						map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom-4).addLayer(tile_layer);						
						marker = new L.Marker(new L.LatLng(gon.lat, gon.lon),{
							draggable: true
						});
						marker.on("dragend",function(e){
							var target = e.target;							
							$.post("/"+gon.locale+"/events/getLocation/addr",{lat:target._latlng.lat,lng:target._latlng.lng},function(data){								
									$("#event_lat").val(target._latlng.lat);
									$("#event_lon").val(target._latlng.lng);									
									$("#event_address").val(data);
							});																					
						});
						map.addLayer(marker);
						window.setTimeout(function(){
							alert("Can't find coordinates! Select them on the map.");
						},500);
						
					});					
				}
				else{					
					$("#control-map").animate({"opacity":0},1000,function(){
						$(this).empty().attr({
							class: "control-map",
							style: ""
						}).hide();						
					});
					$("#event_lat").val(parseFloat(data[0]));
					$("#event_lon").val(parseFloat(data[1]));
				}
			});
			
			return false;
		}
	});
});
