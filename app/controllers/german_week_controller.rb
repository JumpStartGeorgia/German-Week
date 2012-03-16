class GermanWeekController < ApplicationController
  def index  
  
  end

  def search
    isset_category = !params[:category].nil?;
    @events = Event.search(params[:search], isset_category);
#abort(@events.inspect)
    if !isset_category
      search = params[:search].nil? ? '' : params[:search];
      boldpart = "<b>" + search + "</b>";
      if !@events.nil?
        @events.each { |event|
          event.title = event.title.split(search).join(boldpart).html_safe
          event.description = event.description.split(search).join(boldpart).html_safe
        }
      end
    end

    @categories = Category.all

  end

end
