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
//= require fancybox
//= require_tree .

$(document).ready(function(){
  // search button click event
  $("#search_show_button").click(function(){
  	var form_container = $('#search_form_container');
				form_container.slideToggle();
				form_container.find('input[type="text"]').focus();
  });

  // show image caption
  if (gon.show_img_caption){
    $(gon.img_caption_id).jcaption({
      wrapperClass: gon.img_caption_class,
      requireText: false
    });
  }
  
});

