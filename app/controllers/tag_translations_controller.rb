class TagTranslationsController < ApplicationController
  # GET /tag_translations
  # GET /tag_translations.json
  def index
    @tag_translations = TagTranslation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tag_translations }
    end
  end

  # GET /tag_translations/1
  # GET /tag_translations/1.json
  def show
    @tag_translation = TagTranslation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tag_translation }
    end
  end

  # GET /tag_translations/new
  # GET /tag_translations/new.json
  def new
    @tag_translation = TagTranslation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tag_translation }
    end
  end

  # GET /tag_translations/1/edit
  def edit
    @tag_translation = TagTranslation.find(params[:id])
  end

  # POST /tag_translations
  # POST /tag_translations.json
  def create
    @tag_translation = TagTranslation.new(params[:tag_translation])

    respond_to do |format|
      if @tag_translation.save
        format.html { redirect_to @tag_translation, :notice => 'Tag translation was successfully created.' }
        format.json { render :json => @tag_translation, :status => :created, :location => @tag_translation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tag_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tag_translations/1
  # PUT /tag_translations/1.json
  def update
    @tag_translation = TagTranslation.find(params[:id])

    respond_to do |format|
      if @tag_translation.update_attributes(params[:tag_translation])
        format.html { redirect_to @tag_translation, :notice => 'Tag translation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tag_translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_translations/1
  # DELETE /tag_translations/1.json
  def destroy
    @tag_translation = TagTranslation.find(params[:id])
    @tag_translation.destroy

    respond_to do |format|
      format.html { redirect_to tag_translations_url }
      format.json { head :ok }
    end
  end
end
