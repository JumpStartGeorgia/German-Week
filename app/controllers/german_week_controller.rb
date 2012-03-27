class GermanWeekController < ApplicationController
  def index  
<<<<<<< HEAD
=======
  end

  def search
    if params[:category].nil?
      search = params[:search].nil? ? '' : params[:search]
      search_in = params[:search_in].nil? ? '' : params[:search_in]
      isset_category = false
    else
      search = params[:category]
      isset_category = true
    end

    @events = Event.search(search, search_in, isset_category, params[:page])

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
>>>>>>> 35da09c3b932b2a92b4696cec1a98a75898f50b4

  end

end
