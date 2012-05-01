class EventsController < ApplicationController


  before_filter :authenticate_user!, :except => [:index, :show, :day, :category, :exportICS, :getEventsByDay, :slider_images]


  # GET /events
  # GET /events.json
  def index
		if params[:format] == "pdf"
	    @events = Event.order("start ASC")
		else
	    @events = Event.paginate(:page => params[:page]).order("start ASC")
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
      format.pdf do
        render :pdf			=> 'events',
               :template		=> 'shared/_event_list.html.erb',
               :layout			=> 'pdf.html'			# use 'pdf.html' for a pdf.html.erb file
      end
     end
  end

  # GET /events/day/date
  # GET /events/day.js/date  - called when loading the menu pop-up
  # GET /events/day.json/date
  def day
		@date = convert_to_date(params[:date])
		if !@date.nil?
			# if making pdf, get all events
			if params[:format] == "pdf"
			  @events = Event.find_by_date(params[:date])
			else
			  @events = Event.find_by_date(params[:date],true,params[:page])
			end
		end

	  respond_to do |format|
	    format.html # day.html.erb
	    format.js
	    format.json { render :json => @events }
	    format.pdf do
	      render :pdf			=> 'events',
	             :template		=> 'shared/_event_list.html.erb',
	             :layout			=> 'pdf.html'			# use 'pdf.html' for a pdf.html.erb file
	    end
    end
  end

  # GET /events/category?cat
  # GET /events/category.json?cat
  def category
		if params[:format] == "pdf"
	    @events = Event.find_by_category(params[:cat])
		else
	    @events = Event.find_by_category(params[:cat], true, params[:page])
		end

    respond_to do |format|
      format.html # day.html.erb
      format.json { render :json => @events }
      format.pdf do
        render :pdf			=> 'events',
               :template		=> 'shared/_event_list.html.erb',
               :layout			=> 'pdf.html'			# use 'pdf.html' for a pdf.html.erb file
      end
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
		gon.start_year = @event.start.strftime("%Y")
    gon.start_month = @event.start.strftime("%m")
    gon.start_day = @event.start.strftime("%d") 
    gon.start_hour = @event.start.strftime("%H")
    gon.start_minute = @event.start.strftime("%M")
    gon.start_second = @event.start.strftime("%S")
    gon.building_name = @event.building_name
    gon.address = @event.event_address
		gon.show_map = true
		gon.show_img_caption = true
		gon.img_caption_id = "#event_picture"
		gon.img_caption_class = "event_picture_container2"


    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
      format.pdf do
        render :pdf			=> 'events',
               :template		=> 'events/_show.html.erb',
               :layout			=> 'pdf.html',			# use 'pdf.html' for a pdf.html.erb file
							 :show_as_html => params[:debug].present?
               
      end
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    @locales.length.times {@event.event_translations.build}
		gon.edit_event = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
		@event = Event.includes(:event_translations).where("events.id = ?", params[:id]).order("event_translations.locale asc")
		if !@event.nil? && @event.length == 1
			@event = @event[0]
		else
			@event = nil
		end
		# have to remove UTC for it causes the js datepicker to show the wrong time
		gon.start_date = @event.start.to_s.gsub(" UTC", "")
		gon.end_date = @event.end.to_s.gsub(" UTC", "")
		gon.marker_lat = @event.lat
		gon.marker_lon = @event.lon
		gon.edit_event = true
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
				# reload the js so the map renders
				gon.marker_lat = @event.lat
				gon.marker_lon = @event.lon
				gon.edit_event = true
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
				# reload the js so the map renders
				gon.marker_lat = @event.lat
				gon.marker_lon = @event.lon
				gon.edit_event = true
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
  
  def exportICS
  	# define calendar
  	calendar = Icalendar::Calendar.new  	
  	
  	# get all event data from database
  	output_file_name = params[:typespec]
  	
    data = Event.find_for_ics(params[:type], params[:typespec])
  	case params[:type]
  		when "event" 
  			output_file_name = data.title.gsub(/[^0-9A-Za-z ]/,'').split.join('_')
  			data = [data]
			when "sponsor"
				output_file_name = Sponsor.find(params[:typespec]).title.gsub(/[^0-9A-Za-z ]/,'').split.join('_')
  	end
  									
		# fill calendar with events and event data
		if data.nil? || data.length == 0
		  redirect_to "/"
	  else
  		data.each do |event_each|
  			# create calendar event
    		event = Icalendar::Event.new
  		
  			# fill event with data
  			event.dtstart = event_each.start.strftime("%Y%m%dT%H%M%SZ")
  			event.dtend = event_each.end.strftime("%Y%m%dT%H%M%SZ") if !event_each.end.nil?
  			event.description = event_each.description.to_s
  			event.summary = event_each.title.to_s
  			event.location = event_each.event_address.to_s
  			#event.categories = []
  			#event_each.categories.each do |event_each_category|
  			#	event.categories.push Icalendar::Component.new event_each_category.title
  			#end
  			event.klass = "PUBLISH"
		
  			# add event to calendar
  			calendar.add event								
  		end
		
  		# final calendar data output
  		data = calendar.to_ical			
  		# delete all tmp iCalendar files in assets dir
  		Dir.entries(File.dirname(__FILE__)+"/../../public/assets").each do |entry|
    		if entry[(entry.length-4)..(entry.length)] == ".ics"
  				File.delete(File.dirname(__FILE__)+"/../../public/assets/#{entry}")  			
    		end
    	end
    	# create new ics export file
  		ics_file = File.new(File.dirname(__FILE__)+"/../../public/assets/#{output_file_name}.ics","w")
  			ics_file.puts(data)
  		ics_file.close
  		# the respond 
  		# render :file => url, :content_type => "text/calendar; charset=UTF-8" 	
  		redirect_to "/assets/#{output_file_name}.ics"
    end
  end
  
  def getLocation  	
  	case params[:addrorlatlng]
  		when "latlng"
				begin
					location = Geocoder.search("#{params[:address]}")
					render :inline => "#{location[0].latitude},#{location[0].longitude}"
				rescue
					render :inline => "0,0"
				end
			when "addr"
				begin
					location = Geocoder.search("#{params[:lat]},#{params[:lng]}")
					render :inline => "#{location[0].address}"
				rescue
					render :inline => "no address"
				end
		end
  end

  def slider_images
    pathname = 'public/assets/images/header/';
    extensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    images = [];

    Dir.foreach(pathname) do |f|
      if !extensions.include? File.extname(f)[1..4]
        next
      end
      images.push '/assets/images/header/' + f
    end

    max = images.count
    randoms = Set.new();
    loop do
      randoms << Random.rand(max)
      if randoms.size > 2
        break
      end
    end

    random_images = [];
    images.each_with_index do |img, i|
      if randoms.include? i
        random_images.push img
      end
    end

    respond_to do |format|
      format.json { render :json => random_images }
    end

  end
  

	private 

	def convert_to_date(date)
		begin
			d = Date.parse(date)
			return d
		rescue
			return nil
		end
	end
end



