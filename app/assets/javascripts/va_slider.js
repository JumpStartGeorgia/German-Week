function getScrollBarWidth () {  
    var inner = document.createElement('p');  
    inner.style.width = "100%";  
    inner.style.height = "200px";  
  
    var outer = document.createElement('div');  
    outer.style.position = "absolute";  
    outer.style.top = "0px";  
    outer.style.left = "0px";  
    outer.style.visibility = "hidden";  
    outer.style.width = "200px";  
    outer.style.height = "150px";  
    outer.style.overflow = "hidden";  
    outer.appendChild (inner);  
  
    document.body.appendChild (outer);  
    var w1 = inner.offsetWidth;  
    outer.style.overflow = 'scroll';  
    var w2 = inner.offsetWidth;  
    if (w1 == w2) w2 = outer.clientWidth;  
  
    document.body.removeChild (outer);  
  
    return (w1 - w2);  
};

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
  if (screen && screen.width)
  {
    winW = ($(window).height() < $(document).height()) ? (screen.width - getScrollBarWidth()) : screen.width;
    winH = screen.height;
  }
  else if (document.body && document.body.offsetWidth)
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

function Va_slider (options)
{
  if (options.element.length == 0)
  {
    // return if the element doesn't exist
    return;
  }

  // save the current instance of a function in a variable
  var instance = this;

  this.change_slide = function (index)
  {
    // stop all animations
    instance.slider.element.find('*').stop(true, true);

    // fade out the current slide
    $(instance.slider.slides[instance.slider.active]).fadeOut(instance.slider.timeout);
    // fade in the 'index'-th one
    $(instance.slider.slides[index]).fadeIn(instance.slider.timeout);

    // if the switcher circles are shown
    if (show_circles)
    {
      // find the current selected circle and deselect it
      instance.slider.element.find('.circle_selected').attr('class', 'circle');
      // select the one with attribute index equal to index argument
      instance.slider.element.find('.circle[index=' + index + ']')[0].setAttribute('class', 'circle_selected');
    }

    // save the index of current slide so then we can fade it out
    instance.slider.active = index;
  }

  this.change_slide_automatically = function (index)
  {
    // calculate index of a next slide
    // if the current one is the last one, start from 0, otherwise increase it by 1
    index = (instance.slider.slides.length <= (+ instance.slider.active + 1)) ? 0 : + instance.slider.active + 1;
    instance.change_slide(index);
    // restart timer so slideshow doesn't stop
    instance.slider.timer.restart();
  }

  var images = [],
      parent = [],
      group = null,
      innercont = null,
      gwidth = 0,
      math = Math;

  this.proc_images_rec = function (data, i)
  {
    if (typeof(data[i].image_url) != 'string')
    {
      if ((i + 1) < data.length)
      {
        instance.proc_images_rec(data, i + 1);
      }
      else
      {
        return;
      }
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

    if (instance.slider.show == 'one')
    {
      parent[i] = instance.slider.container.appendChild(parent[i]);
      parent[i].appendChild(images[i]);
    }

    if (instance.slider.show == 'many' && i == 0)
    {
      group = document.createElement('div');
      group.setAttribute('class', 'group');
      group = instance.slider.container.appendChild(group);
      gwidth = 0;
      innercont = document.createElement('div');
      innercont.setAttribute('class', 'inner-cont');
      innercont = group.appendChild(innercont);
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
          innercont = document.createElement('div');
          innercont.setAttribute('class', 'inner-cont');
          innercont = group.appendChild(innercont);
        }
        parent[i] = innercont.appendChild(parent[i]);
        parent[i].appendChild(images[i]);

        slide_name = 'group';
        var p = (instance.slider.height - this.height) / 2;
        $(group).css('padding', p + 'px 0px');
      }

      $(instance.slider.container).find('.loader div').html(math.round((+ i + 1) / data.length * 100) + '%');

      if (i == (data.length - 1))
      {
        $(instance.slider.container.find('.' + slide_name)).fadeIn('fast');
        $(instance.slider.container.find('.loader')).fadeOut('fast');


        if (instance.slider.show == 'one')
        {
          instance.slider.element.find('.overlay').show();
        }

        if (show_circles)
        {
          instance.slider.element[0].find('.switcher_circles').style.display = "block";
        }

        instance.slider.slides = instance.slider.container.getElementsByClassName(slide_name);

        instance.slider.timer = new Timer(instance.change_slide_automatically, instance.slider.delay);
      }
      else if ((i + 1) < data.length)
      {
        instance.proc_images_rec(data, i + 1);
      }
    }
  }

  instance.slider = {
    width:        options.width        || 900,
    height:       options.height       || 300,    // it's the minimum height
    delay:        options.delay        || 1000,   // the time each slide will stay visible
    timeout:      options.timeout      || 1000,   // the time the process of changing the slide will take
    margin:       options.margin       || 10,     // if there are many slides visible at the same time, margin between them
    max_circles:  options.max_circles  || 9,
    show:         options.show         || 'one',  // show one or many slides at each time
    element:      options.element,                // element where everything will be added
    timer:        null,
    active:       0                               // index of the current (active) visible slide
  };

  // resize the element according to options
  instance.slider.element.height(instance.slider.height);
  instance.slider.element.width(instance.slider.width);

  // get the data from gon
  // for now there are 2 of them - 'header_slider_data' and 'footer_slider_data'
  // so the options.name would be 'header' or 'footer'
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
         '<div class="container"><div class="loader"><div></div></div>';

  instance.slider.element.prepend(html);
  instance.slider.container = instance.slider.element[0].find('.container');

  instance.proc_images_rec(data, 0);

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
    height: 90,
    delay : 8000,
    timeout : 1000,
    name: 'footer',
    show: 'many',
    margin: 20,
    element: $('#partners .slider')
  };
  
  var footer = new Va_slider(ops);

});
