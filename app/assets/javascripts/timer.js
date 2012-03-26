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
