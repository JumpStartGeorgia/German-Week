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
			$.post("/"+gon.locale+"/location",{address:$("#event_address").val()},function(data){								
				data = data.split(',');
				if(parseFloat(data[0]) == 0 && parseFloat(data[1]) == 0){
					$("#control-map").show().animate({"opacity":1},1000);
				}
				else{
					$("#control-map").animate({"opacity":0},1000,function(){$(this).hide()});
					$("#event_lat").val(parseFloat(data[1]));
					$("#event_lon").val(parseFloat(data[0]));
				}
			});
			
			return false;
		}
	});
});
