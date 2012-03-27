class EventsController < ApplicationController
<<<<<<< HEAD
  before_filter :authenticate_user!, :except => [:index, :show, :exportICSById, :exportICSByDate]
=======
  before_filter :authenticate_user!, :except => [:index, :show, :day, :category]
>>>>>>> 35da09c3b932b2a92b4696cec1a98a75898f50b4

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/day?date
  # GET /events/day.js?date  - called when loading the menu pop-up
  # GET /events/day.json?date
  def day
    @events = Event.find_by_date(params[:date],params[:page])

    respond_to do |format|
      format.html # day.html.erb
      format.js
      format.json { render :json => @events }
    end
  end

  # GET /events/category?cat
  # GET /events/category.json?cat
  def category
    @events = Event.find_by_category(params[:cat], params[:page])
    @categories = Category.all

    respond_to do |format|
      format.html # day.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    # load the lat and lon so the map shows
    gon.lat = @event.lat
    gon.lon = @event.lon
    gon.popup = @event.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    @locales.length.times {@event.event_translations.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, :notice => 'Event was successfully created.' }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
  
  
  # Events export to ICS by ID
  def exportICSById
  	# define calendar 
	calendar = Icalendar::Calendar.new 
	
	# create calendar event
	event = Icalendar::Event.new
	
	# get all event data from database
	data = Event.find params[:id]

	# fill the calendar event with data	
	event.dtstart = data.start.to_s
	event.dtend = data.end.to_s				
	event.categories = []	
	# Components for event categories
	data.categories.each do |category|				
		event.categories.push Icalendar::Component.new category.title
	end	
	
	event.klass = "PUBLISH"
	
	# add event to calendar  	
  	calendar.add event
  	
  	# final calendar data output  	
  	@data = calendar.to_ical
  	
  	# the respond 
  	render :text => @data, :content_type => "text/calendar; charset=UTF-8" 
  	
  end
  
  
  # Events export to ICS by Date
  def exportICSByDate	
  	# define calendar
  	calendar = Icalendar::Calendar.new  	
  	
  	# get all event data from database
  	data = Event.where("DATE_FORMAT(start,'%Y-%m-%d') <= DATE_FORMAT('#{params[:date]}','%Y-%m-%d') AND 
  						 DATE_FORMAT(end,'%Y-%m-%d') >= DATE_FORMAT('#{params[:date]}','%Y-%m-%d')")  	
  						 
  	# fill calendar with events and event data
	data.each do |event_each|
		# create calendar event
  		event = Icalendar::Event.new
  		
		# fill event with data
		event.dtstart = event_each.start.to_s
		event.dtend = event_each.end.to_s
		event.categories = []
		event_each.categories.each do |event_each_category|
			event.categories.push Icalendar::Component.new event_each_category.title
		end
		event.klass = "PUBLISH"
		
		# add event to calendar
		calendar.add event
		
	end
	
	# final calendar data output
	@data = calendar.to_ical	
	
	# the respond 
	render :text => @data, :content_type => "text/calendar; charset=UTF-8" 
	
  end
  
end



