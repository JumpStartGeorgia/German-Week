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
