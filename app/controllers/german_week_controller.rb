class GermanWeekController < ApplicationController
  def index  

  end

  def search
    search = params[:search].nil? ? false : params[:search]
    category = params[:category].nil? ? false : params[:category]

    @events = Event.search(search, category, params[:page])

    if search
      boldpart = "<span class=\"matched_term\">" + search + "</span>"
      if !@events.nil?
        @events.each { |event|
          event.title = event.title.split(search).join(boldpart).html_safe
          event.description = event.description.split(search).join(boldpart).html_safe
        }
      end
    end

  end

end
