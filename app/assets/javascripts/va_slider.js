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

Element.prototype.find = function (term)
{
  term = term.split(' ');
  var element = this;
  for (i in term)
  {
    switch (term[i][0])
    {
      case '.':
        element = element.getElementsByClassName(term[i].substring(1))[0];
      break;
      case '#':
        element = element.getElementById(term[i].substring(1));
      break;
    }
  }
  return element;
}

Element.prototype.remove = function ()
{
  this.parentNode.removeChild(this);
}

function Va_slider (options)
{
  if (options.element.length == 0)
  {
    return;
  }

  var instance = this;

  this.change_slide = function (index)
  {
    instance.slider.element.find('*').stop(true, true);
    $(instance.slider.slides[instance.slider.active]).fadeOut(instance.slider.timeout);
    $(instance.slider.slides[index]).fadeIn(instance.slider.timeout);

    if (show_circles)
    {
      instance.slider.element.find('.circle_selected').attr('class', 'circle');
      instance.slider.element.find('.circle[index=' + index + ']')[0].setAttribute('class', 'circle_selected');
    }

    instance.slider.active = index;
  }

  this.change_slide_automatically = function (index)
  {
    index = (instance.slider.slides.length <= (+ instance.slider.active + 1)) ? 0 : + instance.slider.active + 1;
    instance.change_slide(index);
    instance.slider.timer.restart();
  }

  instance.slider = {
    width:        options.width        || 900,
    height:       options.height       || 300,
    delay:        options.delay        || 1000,
    timeout:      options.timeout      || 1000,
    margin:       options.margin       || 10,
    max_circles:  options.max_circles  || 9,
    show:         options.show         || 'one',
    element:      options.element,
    timer:        null,
    active:       0
  };
  instance.slider.element.height(instance.slider.height);
  instance.slider.element.width(instance.slider.width);

  data = gon[options.name + '_slider_data']

  var show_circles = (data.length <= instance.slider.max_circles && options.name != 'footer') ? true : false,
      circles_html = '';

  if (show_circles)
  {
    for (i = 0; i < data.length; i ++)
    {
      classname = (i == 0) ? 'circle_selected' : 'circle';
      circles_html += '<div class="' + classname + '" index="' + i + '"></div>';
    }

    circles_html = '<div class="switcher_circles">' + circles_html + '</div>';
  }

  html = '<div class="overlay"></div>' + circles_html +
         '<div class="switcher_button" direction="left"></div>' +
         '<div class="switcher_button" direction="right"></div>' +
         '<div class="container"><div class="loader"><div>LOADING</div></div></div>';

  instance.slider.element.prepend(html);
  instance.slider.container = instance.slider.element[0].find('.container');

  var images = [],
      parent = [],
      group = null,
      j = 0;

  for (i in data)
  {
    if (typeof(data[i].image_url) != 'string')
    {
      continue;
    }
    images[i] = new Image();
    images[i].src = data[i].image_url;

    if (typeof (data[i].url) == 'string' && data[i].url.length > 1)
    {
      parent[i] = document.createElement('a');
      parent[i].setAttribute('href', data[i].url);
    }
    else
    {
      parent[i] = document.createElement('div');
    }
    if (typeof (data[i].title) == 'string' && data[i].title.length > 0)
    {
      parent[i].setAttribute('title', data[i].title);
      images[i].setAttribute('alt', data[i].title);
    }
    parent[i].setAttribute('class', 'slide');

    parent[i] = instance.slider.container.appendChild(parent[i]);
    parent[i].appendChild(images[i]);

    if (instance.slider.show == 'many' && i == 0)
    {
      group = document.createElement('div');
      group.setAttribute('class', 'group');
      group = instance.slider.container.appendChild(group);
      var gwidth = 0;
    }

    images[i].onload = function ()
    {
      if (instance.slider.show == 'one')
      {
        new_ds = adjust_dimensions(this.width, this.height, instance.slider.width, instance.slider.height);
        this.width  = this.style.width  = new_ds.width;
        this.height = this.style.height = new_ds.height;

        slide_name = 'slide';
      }
      else
      {
        if (instance.slider.width >= (gwidth + this.width + instance.slider.margin))
        {
          gwidth += this.width + instance.slider.margin;
        }
        else
        {
          gwidth = this.width + instance.slider.margin;
          group = document.createElement('div');
          group.setAttribute('class', 'group');
          group = instance.slider.container.appendChild(group);
        }
        group.appendChild(parent[j]);
        parent[j].appendChild(images[j]);
        $(group).css('left', (instance.slider.width - gwidth) / 2);

        slide_name = 'group';
      }

      if (j == (data.length - 1))
      {
        instance.slider.container.find('.' + slide_name).style.display = "block";
        instance.slider.container.find('.loader').remove();
        
        if (show_circles)
        {
          instance.slider.element[0].find('.switcher_circles').style.display = "block";
        }

        instance.slider.slides = instance.slider.container.getElementsByClassName(slide_name);

        instance.slider.timer = new Timer(instance.change_slide_automatically, instance.slider.delay);
      }
      j ++;
    }
  }

  if (show_circles)
  {
    instance.slider.element.find('.circle, .circle_selected').click(function()
    {
      if (this.getAttribute('class') == 'circle_selected')
      {
        return;
      }
      instance.change_slide(this.getAttribute('index'));
      instance.slider.timer.restart();
    });
  }

  instance.slider.element.find('.switcher_button').click(function()
  {
    var direction = this.getAttribute('direction');
    if (direction == 'left')
    {
      index = (instance.slider.active == 0) ? + instance.slider.slides.length - 1 : + instance.slider.active - 1;
    }
    else
    {
      index = (instance.slider.slides.length <= (+ instance.slider.active + 1)) ? 0 : + instance.slider.active + 1;
    }

    instance.change_slide(index);
    instance.slider.timer.restart();
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
    name: 'header',
    element: $('#s1')
  };

  var header = new Va_slider(options);

  var ops =
  {
    width: 900,
    height: 134,
    delay : 8000,
    timeout : 1000,
    name: 'footer',
    show: 'many',
    margin: 20,
    element: $('#partners .slider')
  };
  
  var footer = new Va_slider(ops);

});
