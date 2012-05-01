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

function adjust_dimensions (e_w, e_h, max_w, max_h, vertical_limit)
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

function get_slide (index)
{
  return slider.container.getElementsByClassName('slider_img_' + index)[0];
}

function change_slide (index)
{
  for (i = 0; i < 3; i ++)
  {
    slider.slides[i].style.left = slider.offsets[slider.matrix[index][i]] + PX;
  }

  slider.active = index;
}

$.prototype.va_slider = function (options)
{
  t1 = microtime();

  slider = {
    width: options.width || 900,
    height: options.height || 300,
    middle_percent: options.middle_percent || 80,
    delay: options.delay || 1000,
    timeout: options.timeout || 1000,
    element: $(this),
    active: 1
  };
  slider.element.height(slider.height);
  slider.element.width(slider.width);

  image_paths = gon[options.name + '_slider_images']

  var switcher_circles_html = '';
  for (i = 0; i < image_paths.length; i ++)
  {
    classname = (i == 0) ? 'circle_selected' : 'circle';
    switcher_circles_html += '<div class="' + classname + '" index="' + i + '"></div>';
  }
  html = '<div class="overlay"></div>' +
         '<div class="switcher_circles">' + switcher_circles_html + '</div>' +
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
    images[i].style.display = "none";
    slider.container.appendChild(images[i]);
    images[i].onload = function ()
    {
      new_ds = adjust_dimensions(this.width, this.height, slider.width, slider.height);
      this.width  = this.style.width  = new_ds.width;
      this.height = this.style.height = new_ds.height;
      this.setAttribute('class', 'slider_img_' + j);
      //images[j].style.display = "block";
      j ++;
      if (j == (image_paths.length - 1))
      {
        slider.container.removeChild(slider.container.getElementsByClassName('loader')[0]);
      }
    }
  }


  $('.switcher_circle, .switcher_circle_selected').click(function()
  {
    if (this.getAttribute('class') == 'switcher_circle_selected')
    {
      return;
    }
    change_slide(this.getAttribute('index'));
    document.getElementsByClassName('switcher_circle_selected')[0].setAttribute('class', 'switcher_circle');
    this.setAttribute('class', 'switcher_circle_selected');
  });

  //timer = new Timer(change_slide_automatic, slider.delay);
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
