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

var PX = 'px';

function adjust_dimensions (e_w, e_h, max_w, max_h, vertical_limit)
{
  vertical_limit = vertical_limit || false;
  max_w = max_w;
  max_h = max_h;
  var k = vertical_limit ? Math.max((e_h / max_h), (e_w / max_w)) : Math.min((e_h / max_h), (e_w / max_w));
  new_w = e_w / k;
  new_h = e_h / k;

  return {
	  'width'  : new_w,
  	'height' : new_h,
  };
}

$.prototype.va_slider = function (options)
{
  function change_slide (index)
  {
    slider.element.find('*').stop(true, true);
    $(slider.slides[slider.active]).fadeOut(slider.timeout);
    $(slider.slides[index]).fadeIn(slider.timeout);

    slider.element.find('.circle_selected').attr('class', 'circle');
    slider.element.find('.circle[index=' + index + ']')[0].setAttribute('class', 'circle_selected');

    slider.active = index;
  }

  function change_slide_automatically (index)
  {
    index = (slider.slides.length <= (+ slider.active + 1)) ? 0 : + slider.active + 1;
    change_slide(index);
    slider.timer.restart();
  }

  t1 = microtime();

  slider = {
    width:        options.width        || 900,
    height:       options.height       || 300,
    max_circles:  options.max_circles  || 9,
    delay:        options.delay        || 1000,
    timeout:      options.timeout      || 1000,
    timer:        null,
    element:      $(this),
    active:       0
  };
  slider.element.height(slider.height);
  slider.element.width(slider.width);

  image_paths = gon[options.name + '_slider_images']

  var show_circles = (image_paths.length <= slider.max_circles) ? true : false,
      circles_html = '';

  if (show_circles)
  {
    for (i = 0; i < image_paths.length; i ++)
    {
      classname = (i == 0) ? 'circle_selected' : 'circle';
      circles_html += '<div class="' + classname + '" index="' + i + '"></div>';
    }

    circles_html = '<div class="switcher_circles">' + circles_html + '</div>';
  }

  html = '<div class="overlay"></div>' + circles_html +
         '<div class="switcher_button" direction="left"></div>' +
         '<div class="switcher_button" direction="right"></div>' +
         '</div>' +
         '<div class="container"><div class="loader"><div>LOADING</div></div></div>';

  slider.element.prepend(html);
  slider.container = slider.element[0].getElementsByClassName('container')[0];

  var images = [],
      j = 0;

  for (i in image_paths)
  {
    if (typeof(image_paths[i]) != 'string')
    {
      continue;
    }
    images[i] = new Image();
    images[i].src = image_paths[i];
    slider.container.appendChild(images[i]);

    images[i].onload = function ()
    {
      new_ds = adjust_dimensions(this.width, this.height, slider.width, slider.height);
      this.width  = this.style.width  = new_ds.width;
      this.height = this.style.height = new_ds.height;
      if (j == (image_paths.length - 1))
      {
        images[0].style.display = "block";
        slider.container.removeChild(slider.container.getElementsByClassName('loader')[0]);
        if (show_circles)
        {
          slider.element.get(0).getElementsByClassName('switcher_circles')[0].style.display = "block";
        }
        slider.slides = slider.container.getElementsByTagName('img');
        slider.timer = new Timer(change_slide_automatically, slider.delay);
      }
      j ++;
    }
  }

  if (show_circles)
  {
    slider.element.find('.circle, .circle_selected').click(function()
    {
      if (this.getAttribute('class') == 'circle_selected')
      {
        return;
      }
      change_slide(this.getAttribute('index'));
      slider.timer.restart();
    });
  }

  slider.element.find('.switcher_button').click(function()
  {
    var direction = this.getAttribute('direction');
    if (direction == 'left')
    {
      index = (slider.active == 0) ? + slider.slides.length - 1 : + slider.active - 1;
    }
    else
    {
      index = (slider.slides.length <= (+ slider.active + 1)) ? 0 : + slider.active + 1;
    }

    change_slide(index);
    slider.timer.restart();
  });

  t2 = microtime();
  /*
  console.log(t2 - t1);
  */
};




$(function ()
{

  var options =
  {
    width: window_dimensions().width,
    height: 220,
    delay : 5000,
    timeout : 1000,
    name: 'header'
  };

  var element = $('#slider');
  if (element.length > 0)
  {
    element.va_slider(options);
  }

});
