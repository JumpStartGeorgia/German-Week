// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var existing_marker;
$(document).ready(function(){

	if(gon.edit_event){
		// load the date time pickers
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

		if (gon.start_date !== undefined &&
				gon.start_date.length > 0)
		{
			$("#event_start").datetimepicker("setDate", new Date(gon.start_date));
		}
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
		if (gon.end_date !== undefined &&
				gon.end_date.length > 0)
		{
			$("#event_end").datetimepicker("setDate", new Date(gon.end_date));
		}



		// load the map
		var map = new L.Map("control-map"), tile_layer = new L.TileLayer(gon.tile_url, {maxZoom: gon.max_zoom, attribution: gon.attribution});
		map.attributionControl = false;
		map.zoomControl = true;
		map._container._leaflet = false;
		if (gon.marker_lat && gon.marker_lat.toString().length > 0 && gon.marker_lon && gon.marker_lon.toString().length > 0){
			map.setView(new L.LatLng(gon.marker_lat, gon.marker_lon), gon.zoom).addLayer(tile_layer);
			existing_marker = new L.Marker(new L.LatLng(gon.marker_lat, gon.marker_lon),{
				draggable: true
			});
			existing_marker.on("dragend",function(e){
				var target = e.target;
				$("#event_lat").val(target._latlng.lat);
				$("#event_lon").val(target._latlng.lng);						
			});
			map.addLayer(existing_marker);
		} else {
				map.setView(new L.LatLng(gon.lat, gon.lon), gon.zoom).addLayer(tile_layer);
		}
	
		$("#btn-getaddr").live({
			'click': function(){
				// look for an address
				var frmAddress = "";
				if ($("#event_event_translations_attributes_0_address").val()) {
					frmAddress = $("#event_event_translations_attributes_0_address").val();
				}else if ($("#event_event_translations_attributes_1_address").val()) {
					frmAddress = $("#event_event_translations_attributes_1_address").val();
				}else if ($("#event_event_translations_attributes_2_address").val()) {
					frmAddress = $("#event_event_translations_attributes_2_address").val();
				}

				$.post("/"+gon.locale+"/events/getLocation/latlng",{address:frmAddress},function(data){								
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
