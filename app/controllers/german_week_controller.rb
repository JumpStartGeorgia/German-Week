class GermanWeekController < ApplicationController
  def index  
  end

  def search
    if params[:category].nil?
      search = params[:search].nil? ? '' : params[:search]
      isset_category = false
    else
      search = params[:category]
      isset_category = true
    end

    @events = Event.search(search, isset_category)

    if !isset_category
      boldpart = "<b>" + search + "</b>"
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
