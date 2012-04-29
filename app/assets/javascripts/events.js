// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
	$('#event_start').datetimepicker({
			dateFormat: 'yy/mm/dd',
			timeFormat: 'hh:mm',
			separator: ' ',
		  onClose: function(dateText, inst) {
		      var endDateTextBox = $('#event_end');
/*
		      if (endDateTextBox.val() != '') {
		          var testStartDate = new Date(dateText);
		          var testEndDate = new Date(endDateTextBox.val());
		          if (testStartDate > testEndDate)
		              endDateTextBox.val(dateText);
		      }
		      else {
		          endDateTextBox.val(dateText);
		      }
*/
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
var map;
var existing_marker;
$(function(){


	if(!gon.show_map && $("#control-map").length>0){
		var map = new L.Map("control-map"), tile_layer = new L.TileLayer(gon.tile_url, {maxZoom: gon.max_zoom, attribution: gon.attribution});

				
		map.attributionControl = false;
		map.zoomControl = true;
		map._container._leaflet = false;
		map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom).addLayer(tile_layer);

		if (gon.lat && gon.lat.length > 0 && gon.lon && gon.lon.length > 0){
			existing_marker = new L.Marker(new L.LatLng(gon.lat, gon.lon),{
				draggable: true
			});
			existing_marker.on("dragend",function(e){
				var target = e.target;
				$("#event_lat").val(target._latlng.lat);
				$("#event_lon").val(target._latlng.lng);						
			});
			map.addLayer(existing_marker);
		}
	
		$("#btn-getaddr").live({
			'click': function(){
				$.post("/"+gon.locale+"/events/getLocation/latlng",{address:$("#event_address").val()},function(data){								
					data = data.split(',');
																
					map.setView(new L.LatLng(data[0], data[1]), gon.zoom);						
					var marker = new L.Marker(new L.LatLng(data[0], data[1]),{
						draggable: true
					});

          // save the lat/lon values
					$("#event_lat").val(data[0]);
					$("#event_lon").val(data[1]);						
            
					marker.on("dragend",function(e){
						var target = e.target;							
						$("#event_lat").val(target._latlng.lat);
						$("#event_lon").val(target._latlng.lng);						
					});
					// if there are any markers already on map, remove them
					if (existing_marker){
						map.removeLayer(existing_marker);
					}
					map.addLayer(marker);
					existing_marker = marker;

				
				
				});
			
				return false;
			}
		});
	}
});
