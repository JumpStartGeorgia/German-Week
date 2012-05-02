class GermanWeekController < ApplicationController
  def index  
    @page = Page.find_by_name("ambassador")
  end

  def search
    search = params[:search].nil? ? false : params[:search]
    category = params[:category].nil? ? false : params[:category]

    @events = Event.search(search, category, params[:page])

  end

end
