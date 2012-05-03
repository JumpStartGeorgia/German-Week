class ImageHeadersController < ApplicationController
  before_filter :authenticate_user!

  # GET /image_headers
  # GET /image_headers.json
  def index
    @image_headers = ImageHeader.paginate(:page => params[:page]).order("id ASC")


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @image_headers }
    end
  end

  # GET /image_headers/1
  # GET /image_headers/1.json
  def show
    @image_header = ImageHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image_header }
    end
  end

  # GET /image_headers/new
  # GET /image_headers/new.json
  def new
    @image_header = ImageHeader.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image_header }
    end
  end

  # GET /image_headers/1/edit
  def edit
    @image_header = ImageHeader.find(params[:id])
  end

  # POST /image_headers
  # POST /image_headers.json
  def create
    @image_header = ImageHeader.new(params[:image_header])

    respond_to do |format|
      if @image_header.save
        format.html { redirect_to @image_header, notice: 'Image header was successfully created.' }
        format.json { render json: @image_header, status: :created, location: @image_header }
      else
        format.html { render action: "new" }
        format.json { render json: @image_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /image_headers/1
  # PUT /image_headers/1.json
  def update
    @image_header = ImageHeader.find(params[:id])

    respond_to do |format|
      if @image_header.update_attributes(params[:image_header])
        format.html { redirect_to @image_header, notice: 'Image header was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @image_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_headers/1
  # DELETE /image_headers/1.json
  def destroy
    @image_header = ImageHeader.find(params[:id])
    @image_header.destroy

    respond_to do |format|
      format.html { redirect_to image_headers_url }
      format.json { head :ok }
    end
  end
end
