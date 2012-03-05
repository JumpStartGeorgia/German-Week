class EventSponsorsController < ApplicationController
  # GET /event_sponsors
  # GET /event_sponsors.json
  def index
    @event_sponsors = EventSponsor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @event_sponsors }
    end
  end

  # GET /event_sponsors/1
  # GET /event_sponsors/1.json
  def show
    @event_sponsor = EventSponsor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event_sponsor }
    end
  end

  # GET /event_sponsors/new
  # GET /event_sponsors/new.json
  def new
    @event_sponsor = EventSponsor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event_sponsor }
    end
  end

  # GET /event_sponsors/1/edit
  def edit
    @event_sponsor = EventSponsor.find(params[:id])
  end

  # POST /event_sponsors
  # POST /event_sponsors.json
  def create
    @event_sponsor = EventSponsor.new(params[:event_sponsor])

    respond_to do |format|
      if @event_sponsor.save
        format.html { redirect_to @event_sponsor, :notice => 'Event sponsor was successfully created.' }
        format.json { render :json => @event_sponsor, :status => :created, :location => @event_sponsor }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event_sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /event_sponsors/1
  # PUT /event_sponsors/1.json
  def update
    @event_sponsor = EventSponsor.find(params[:id])

    respond_to do |format|
      if @event_sponsor.update_attributes(params[:event_sponsor])
        format.html { redirect_to @event_sponsor, :notice => 'Event sponsor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event_sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /event_sponsors/1
  # DELETE /event_sponsors/1.json
  def destroy
    @event_sponsor = EventSponsor.find(params[:id])
    @event_sponsor.destroy

    respond_to do |format|
      format.html { redirect_to event_sponsors_url }
      format.json { head :ok }
    end
  end
end
