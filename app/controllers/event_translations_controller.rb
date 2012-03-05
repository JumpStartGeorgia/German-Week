class EventTranslationsController < ApplicationController
  # GET /event_translations
  # GET /event_translations.json
  def index
    @event_translations = EventTranslation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @event_translations }
    end
  end

  # GET /event_translations/1
  # GET /event_translations/1.json
  def show
    @event_translation = EventTranslation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event_translation }
    end
  end

  # GET /event_translations/new
  # GET /event_translations/new.json
  def new
    @event_translation = EventTranslation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event_translation }
    end
  end

  # GET /event_translations/1/edit
  def edit
    @event_translation = EventTranslation.find(params[:id])
  end

  # POST /event_translations
  # POST /event_translations.json
  def create
    @event_translation = EventTranslation.new(params[:event_translation])

    respond_to do |format|
      if @event_translation.save
        format.html { redirect_to @event_translation, :notice => 'Event translation was successfully created.' }
        format.json { render :json => @event_translation, :status => :created, :location => @event_translation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /event_translations/1
  # PUT /event_translations/1.json
  def update
    @event_translation = EventTranslation.find(params[:id])

    respond_to do |format|
      if @event_translation.update_attributes(params[:event_translation])
        format.html { redirect_to @event_translation, :notice => 'Event translation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /event_translations/1
  # DELETE /event_translations/1.json
  def destroy
    @event_translation = EventTranslation.find(params[:id])
    @event_translation.destroy

    respond_to do |format|
      format.html { redirect_to event_translations_url }
      format.json { head :ok }
    end
  end
end
