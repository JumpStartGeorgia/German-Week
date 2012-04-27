// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require i18n
//= require i18n/translations
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require vendor
//= require id_countdown
//= require_tree .

$(document).ready(function(){
	// load the megamenu script
	$(".mega-menu").dcVerticalMegaMenu({
    rowItems: '4',
    speed: 'slow',
    effect: 'fade',
    direction: 'right',
    arrow: 'false'
	});
	// on mouseover, get the events for the date in the link and load it
	// into megamenu
  $("a.event_menu_link").mouseover(submitWithAjax);

	function submitWithAjax() {
    $.get(this.href, $(this).serialize(), null, "script");
	};

	$.ajaxSetup({
	  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
	});


  // search button click event
  document.getElementById('search_show_button').onclick = function () {
    var form_container = $('#search_form_container');
    form_container.slideToggle();
    form_container.find('input[type="text"]').focus();
  }


  // hide the alert and notice containers if they are empty
  $('p.notice, p.alert').each(function(){ ($.trim($(this).html()).length == 0) && $(this).hide(); });
});





