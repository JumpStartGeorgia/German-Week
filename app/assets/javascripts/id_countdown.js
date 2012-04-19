

$(function(){	

	if( gon.end_year !== '' ){
		var abr = $("#time-abr"),time = $("#time"),ts = new Date(gon.end_year, gon.end_month-1, gon.end_day, gon.end_hour, gon.end_minute, gon.end_second),i=0;    						
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
			__(html,'TAG');
		__(html,'</span>');
		__(html,'<span class="stunden">');
			__(html,'STUNDEN');
		__(html,'</span>');
		__(html,'<span class="minuten">');
			__(html,'MINUTEN');
		__(html,'</span>');
		abr.append(html.join(''));
	}
});


