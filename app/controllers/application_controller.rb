class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :init_gon
  
  def set_locale 	
    I18n.locale = params[:locale] if params[:locale]
    @locales = Locale.all
  end
  
  # pre-load gon so js does not through errors on pages that do not use gon
  def init_gon
    gon.tile_url = 'http://tile.mapspot.ge/en/{z}/{x}/{y}.png'
    gon.attribution = 'Map data &copy; <a href="http://jumpstart.ge" target="_blank">JumpStart Georgia</a>'
    gon.map_id = 'map'
    gon.zoom = 16
    gon.max_zoom = 18
  end
  
  def default_url_options(options={})
    { locale: I18n.locale }
  end

end
