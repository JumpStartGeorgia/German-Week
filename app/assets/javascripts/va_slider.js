function microtime (get_as_float)
{
    get_as_float = get_as_float || true;
    var now = new Date().getTime() / 1000;
    var s = parseInt(now, 10);

    return (get_as_float) ? now : (Math.round((now - s) * 1000) / 1000) + ' ' + s;
}

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

function window_dimensions ()
{
  var winW, winH;
  if (document.body && document.body.offsetWidth)
  {
    winW = document.body.offsetWidth;
    winH = document.body.offsetHeight;
  }
  else if (document.compatMode == 'CSS1Compat' && document.documentElement && document.documentElement.offsetWidth)
  {
    winW = document.documentElement.offsetWidth;
    winH = document.documentElement.offsetHeight;
  }
  else if (window.innerWidth && window.innerHeight)
  {
    winW = window.innerWidth;
    winH = window.innerHeight;
  }
  return {
    width: winW,
    height: winH
  };
}

var slider = {},
    PX = 'px';

function adjust_dimensions (e_w, e_h, vertical_limit, max_w, max_h)
{
  vertical_limit = vertical_limit || false;
  max_w = max_w || slider.width;
  max_h = max_h || slider.height;
  var k = vertical_limit ? Math.max((e_h / max_h), (e_w / max_w)) : Math.min((e_h / max_h), (e_w / max_w));
  new_w = e_w / k;
  new_h = e_h / k;

  return {
	'width'  : new_w,
	'height' : new_h,
  };
}

function change_slide (index)
{

}

function change_slide_automatic ()
{

}

$.prototype.va_slider = function (options)
{
  t1 = microtime();

  slider = {
    width: window_dimensions().width,
    height: options.height || 300,
    middle_percent: options.middle_percent || 80,
    delay: options.delay || 1000,
    animation_timeout: options.animation_timeout || 1000,
    element: $(this)
  };
  slider.middle_size = slider.width * slider.middle_percent / 100;
  slider.element.height(slider.height);
  slider.element.width(slider.width);

  var switcher_circles_html = '';
  for (i = 0; i < 3; i ++)
  {
    switcher_circles_html += '<div class="switcher_circle" index="' + i + '"></div>';
  }
  slider_html = '<div class="overlay"></div>' +
                '<div id="switcher_circles">' + switcher_circles_html + '</div>' +
                '<div class="container"></div>';

  slider.element.prepend(slider_html);
  slider.container = slider.element[0].getElementsByClassName('container')[0];
  //slider.container.style.height = '100%';
  //slider.container.style.width = slider.middle_size * 3 + PX;

  document.getElementsByClassName('switcher_circle')[0].setAttribute('class', 'switcher_circle_selected');

  $.getJSON('/en/slider_images.json', function (json)
  {
    var images = [],
        j = 0;
    for (i in json)
    {
      if (typeof(json[i]) != 'string')
      {
        continue;
      }
      images[i] = new Image();
      images[i].src = json[i];
      images[i].onload = function ()
      {
      console.log(images[i]);
        new_ds = adjust_dimensions(this.width, this.height, false, slider.middle_size, slider.height);
        this.width  = this.style.width  = new_ds.width;
        this.height = this.style.height = new_ds.height;
        this.setAttribute('class', 'slider_img_' + j);
        switch (j)
        {
          case 0:
            left = 0 - (this.width - (slider.width - slider.middle_size) / 2);
          break;
          case 1:
            left = (slider.width - slider.middle_size) / 2;
          break;
          case 2:
            left = slider.width + (this.width - (slider.width - slider.middle_size) / 2);
          break;
        }
        this.style.left = left;
        j ++;

        slider.container.appendChild(images[i]);
      }
    }
  });

  $('.switcher_circle, .switcher_circle_selected').click(function()
  {

  });

  timer = new Timer(change_slide_automatic, slider.delay);
  t2 = microtime();
  /*
  console.log(t2 - t1);
  */
};





$(function ()
{

  var options =
  {
    height: 300,
    delay : 5000,
    animation_timeout : 1000
  };

  var element = $('#slider');
  if (element.length > 0)
  {
    element.va_slider(options);
  }

});
