

$(function(){	

	if( gon.start_year !== '' ){
		var abr = $("#time-abr"),time = $("#time"),ts = new Date(gon.start_year, gon.start_month-1, gon.start_day, gon.start_hour, gon.start_minute, gon.start_second),i=0;    						
		time.countdown({
				timestamp: ts
			});
		var days = time.find(".countDays:first"),
			hours = time.find(".countHours:first"),
			minutes = time.find(".countMinutes:first"),
			__ = function(arr,text){
				arr.push(text);
			},html = new Array;
		__(html,'<span class="tag">');
			__(html,I18n.t("datetime.prompts.day"));
		__(html,'</span>');
		__(html,'<span class="stunden">');
			__(html,I18n.t("datetime.prompts.hour"));
		__(html,'</span>');
		__(html,'<span class="minuten">');
			__(html,I18n.t("datetime.prompts.minute"));
		__(html,'</span>');
		abr.append(html.join(''));
	}
});


