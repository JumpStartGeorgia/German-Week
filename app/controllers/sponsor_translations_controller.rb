class SponsorTranslationsController < ApplicationController
  # GET /sponsor_translations
  # GET /sponsor_translations.json
  def index
    @sponsor_translations = SponsorTranslation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sponsor_translations }
    end
  end

  # GET /sponsor_translations/1
  # GET /sponsor_translations/1.json
  def show
    @sponsor_translation = SponsorTranslation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @sponsor_translation }
    end
  end

  # GET /sponsor_translations/new
  # GET /sponsor_translations/new.json
  def new
    @sponsor_translation = SponsorTranslation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @sponsor_translation }
    end
  end

  # GET /sponsor_translations/1/edit
  def edit
    @sponsor_translation = SponsorTranslation.find(params[:id])
  end

  # POST /sponsor_translations
  # POST /sponsor_translations.json
  def create
    @sponsor_translation = SponsorTranslation.new(params[:sponsor_translation])

    respond_to do |format|
      if @sponsor_translation.save
        format.html { redirect_to @sponsor_translation, :notice => 'Sponsor translation was successfully created.' }
        format.json { render :json => @sponsor_translation, :status => :created, :location => @sponsor_translation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @sponsor_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sponsor_translations/1
  # PUT /sponsor_translations/1.json
  def update
    @sponsor_translation = SponsorTranslation.find(params[:id])

    respond_to do |format|
      if @sponsor_translation.update_attributes(params[:sponsor_translation])
        format.html { redirect_to @sponsor_translation, :notice => 'Sponsor translation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @sponsor_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsor_translations/1
  # DELETE /sponsor_translations/1.json
  def destroy
    @sponsor_translation = SponsorTranslation.find(params[:id])
    @sponsor_translation.destroy

    respond_to do |format|
      format.html { redirect_to sponsor_translations_url }
      format.json { head :ok }
    end
  end
end
