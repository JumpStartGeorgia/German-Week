class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :init_gon
  before_filter :set_categories_for_partial
  
  def set_locale 	
    I18n.locale = params[:locale] if params[:locale]
    @locales = Locale.all
  end

  # pre-load gon so js does not through errors on pages that do not use gon
  def init_gon
    lang = I18n.locale.to_s == 'ka' ? 'ka' : 'en'
    gon.tile_url = "http://tile.mapspot.ge/#{lang}/{z}/{x}/{y}.png"
    gon.attribution = 'Map data &copy; <a href="http://jumpstart.ge" target="_blank">JumpStart Georgia</a>'
    gon.map_id = 'map'
    gon.zoom = 16
    gon.max_zoom = 18
    gon.lat = 41.699504919895
		gon.lon = 44.797002757205	
    gon.locale = params[:locale]
  end

  def set_categories_for_partial
    @categories = Category.all
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

end
