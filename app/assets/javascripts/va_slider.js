function Timer (callback, delay)
{
    var timerId, start, remaining = delay;

    this.pause = function ()
    {
        window.clearTimeout(timerId);
        remaining -= new Date() - start;
    };

    this.resume = function ()
    {
        start = new Date();
        timerId = window.setTimeout(callback, remaining);
    };

    this.restart = function ()
    {
        start = new Date();
        window.clearTimeout(timerId);
        remaining = delay;
        timerId = window.setTimeout(callback, remaining);
    };

    this.stop = function ()
    {
        window.clearTimeout(timerId);
    };

    this.resume();
}


  var max_index = 0, cur_index = 0,
  slider_w, slider_h,
  delay, animation_timeout, timer,
  PX = 'px';

  function adjust_dimensions (e_w, e_h, limit, max_w, max_h)
  {
    limit = limit || false;
    max_w = max_w || slider_w;
    max_h = max_h || slider_h;
    var k = limit ? Math.max((e_h / max_h), (e_w / max_w)) : Math.min((e_h / max_h), (e_w / max_w));
    new_w = e_w / k;
    new_h = e_h / k;

    return {
    	'width'  : new_w,
    	'height' : new_h,
    };
  }

  function change_slide (index)
  {
    $('.slider_content').stop(true, true);
    $('.slider_content:visible').fadeOut(animation_timeout);
    $('.slider_content[index="' + index + '"]').fadeIn(animation_timeout);

    document.getElementsByClassName('switcher_circle_selected')[0].setAttribute('class', 'switcher_circle');
    $('.switcher_circle[index="' + index + '"]')[0].setAttribute('class', 'switcher_circle_selected');
  }

  function change_slide_automatic ()
  {
    cur_index = (cur_index == max_index) ? 0 : (+ cur_index + 1);
    change_slide(cur_index);
    timer.restart();
  }

  $.prototype.va_slider = function (options)
  {
    slider_w = options.slider_w || 770,
    slider_h = options.slider_h || 450,
    delay = options.delay || 1000,
    animation_timeout = options.animation_timeout || 1000,
    slideshow_mode = (typeof(options.slideshow_mode) == 'undefined') ? false : options.slideshow_mode;

    var slider_div = $(this),
    container = slider_div.children(),
    content = container.children(),
    slider_html =
	'<div id="switcher_circles"></div>' +
	'<div id="switcher_buttons">' +
	    '<div class="switcher_button" direction="left"><</div>' +
	    '<div class="switcher_button" direction="right">></div>' +
	'</div>';

    if (slideshow_mode)
    {
	slider_html += '<div id="slideshow_starter" todo="start">start slideshow</div>';
    }

    content.addClass('slider_content');
    slider_div.prepend(slider_html);

    content.filter('img').add(content.find('img.resizable')).load(function()
    {
	new_ds = adjust_dimensions(this.width, this.height);
	this.width = new_ds.width;
	this.height = new_ds.height;
    });

    content.find('img.slider_text_image').load(function()
    {
	new_ds = adjust_dimensions(this.width, this.height, true, slider_w/2);
	this.width = new_ds.width;
	this.height = new_ds.height;
    });

    content.each(function (index)
    {
	if (this.tagName.toLowerCase() != 'img')
	{
	    this.style.width = slider_w + PX;
	    this.style.height = slider_h + PX;
	}

	if (index != 0)
	{
	    this.style.display = 'none';
	}

	this.setAttribute('index', index);
    });
    container.show();

    max_index = content.length - 1;
    var switcher_circles_html = '';
    for (i = 0; i <= max_index; i ++)
    {
	switcher_circles_html += '<div class="switcher_circle" index="' + i + '"></div>';
    }

    document.getElementById('switcher_circles').innerHTML += switcher_circles_html;
    document.getElementsByClassName('switcher_circle')[0].setAttribute('class', 'switcher_circle_selected');

    $('.switcher_circle, .switcher_circle_selected').click(function()
    {
	index = this.getAttribute('index');
	if (cur_index == index)
	{
	    return;
	}
	cur_index = index;
	change_slide(cur_index, animation_timeout);
	timer.restart();
    });

    $('.switcher_button').click(function()
    {
	var direction = this.getAttribute('direction');
	if (direction == 'left')
	{
	    cur_index = (cur_index == 0) ? max_index : (+ cur_index - 1);
	}
	else if (direction == 'right')
	{
	    cur_index = (cur_index == max_index) ? 0 : (+ cur_index + 1);
	}
	change_slide(cur_index, animation_timeout);
	timer.restart();
    });


    if (slideshow_mode)
    {
	slider_div.prepend('<div id="slider_controls" todo="pause">PAUSE</div>');
	var controls = document.getElementById('slider_controls');

	controls.onclick = function ()
	{
	    var todo = this.getAttribute('todo');
	    if (todo == 'pause')
	    {
		timer.pause();
		this.innerHTML = 'PLAY';
		this.setAttribute('todo', 'play');
	    }
	    else if (todo == 'play')
	    {
		timer.resume();
		this.innerHTML = 'PAUSE';
		this.setAttribute('todo', 'pause');
	    }
	}

	document.getElementById('slideshow_starter').onclick = function ()
	{
	    var todo = this.getAttribute('todo'),
	    sb = document.getElementById('switcher_buttons'),
	    sc = document.getElementById('switcher_circles');
	    if (todo == 'start')
	    {
		change_slide_automatic();
		sc.style.display = sb.style.display = 'none';
		controls.style.display = 'block';
		this.innerHTML = 'exit slideshow';
		this.setAttribute('todo', 'exit');
	    }
	    else if (todo == 'exit')
	    {
		timer.restart();
		sc.style.display = sb.style.display = 'block';
		controls.style.display = 'none';
		this.innerHTML = 'start slideshow';
		this.setAttribute('todo', 'start');
	    }
	}
    }

    timer = new Timer(change_slide_automatic, delay);
  };


  var options =
  {
	slider_w : 650,
	slider_h : 450,
	delay : 5000,
	animation_timeout : 1000,
	slideshow_mode : true,
  };


$(function ()
{
  var element = $('#slider');
  if (element.length > 0)
  {
    element.va_slider(options);
  }
});
