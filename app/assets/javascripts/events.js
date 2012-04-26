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

$(function(){

	if(!gon.show_map){
		var map = new L.Map("control-map"), tile_layer = new L.TileLayer(gon.tile_url, {maxZoom: gon.max_zoom, attribution: gon.attribution});
				
		map.attributionControl = false;
		map.zoomControl = false;
		$(".leaflet-control-attribution").parent().hide();
		$(".leaflet-control-zoom").parent().hide();
		map._container._leaflet = false;
		map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom-4).addLayer(tile_layer);
	
		$("#btn-getaddr").live({
			'click': function(){
				$("#control-map").animate({
					width: '300px',
					height: '250px',
					opacity: 1
				}, 1000,function(){
					map.zoomControl = true;
					map.attributionControl = true;
					map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom-4);				
				});
			
				$.post("/"+gon.locale+"/latlng",{address:$("#event_address").val()},function(data){								
					data = data.split(',');
																

					map.setView(new L.LatLng(data[0], data[1]), gon.zoom+2);						
					var marker = new L.Marker(new L.LatLng(data[0], data[1]),{
						draggable: true
					});
					marker.on("dragend",function(e){
						var target = e.target;							
						$.post("/"+gon.locale+"/addr",{lat:target._latlng.lat,lng:target._latlng.lng},function(data){								
								$("#event_lat").val(target._latlng.lat);
								$("#event_lon").val(target._latlng.lng);									
						});																					

					});
					map.addLayer(marker);
						

				
				
				});
			
				return false;
			}
		});
	}
});
