class SponsorsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :view]

  # GET /sponsors/view/:type
  # GET /sponsors/view/:type.json
  def view
    @sponsors = Sponsor.get_by_type(params[:type])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sponsors }
    end
  end

  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sponsors }
    end
  end

  # GET /sponsors/1
  # GET /sponsors/1.json
  def show
    @sponsor = Sponsor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @sponsor }
    end
  end

  # GET /sponsors/new
  # GET /sponsors/new.json
  def new
    @sponsor = Sponsor.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    @locales.length.times {@sponsor.sponsor_translations.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @sponsor }
    end
  end

  # GET /sponsors/1/edit
  def edit
		@sponsor = Sponsor.includes(:sponsor_translations).where("sponsors.id = ?", params[:id]).order("sponsor_translations.locale asc")
		if !@sponsor.nil? && @sponsor.length == 1
			@sponsor = @sponsor[0]
		else
			@sponsor = nil
		end
  end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @sponsor = Sponsor.new(params[:sponsor])

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to @sponsor, :notice => 'Sponsor was successfully created.' }
        format.json { render :json => @sponsor, :status => :created, :location => @sponsor }
      else
        format.html { render :action => "new" }
        format.json { render :json => @sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sponsors/1
  # PUT /sponsors/1.json
  def update
    @sponsor = Sponsor.find(params[:id])
    
    # if the delete logo is checked, reset the logo to nil
#    if params[:delete_logo] = 1
#      @sponsor.logo = nil
#    end

    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        format.html { redirect_to @sponsor, :notice => 'Sponsor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to sponsors_url }
      format.json { head :ok }
    end
  end
end
