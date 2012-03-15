// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.megamenu
//= require_tree .


$(document).ready(function(){
	// load the megamenu script
	$(".megamenu").megamenu();
	// on mouseover, get the events for the date in the link and load it 
	// into megamenu
  $("a.event_menu_link").mouseover(submitWithAjax);

	function submitWithAjax() {
    $.get(this.href, $(this).serialize(), null, "script");
	};

	$.ajaxSetup({
	  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
	});

});





