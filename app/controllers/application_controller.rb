class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :init_gon
  before_filter :set_categories
  before_filter :set_sponsor_types
  before_filter :set_organisations
  
  def set_locale 	
    I18n.locale = params[:locale] if params[:locale]
    @locales = Locale.order("language asc")
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

  def set_categories
    @categories = Category.includes(:category_translations).order("category_translations.title asc")
  end

  def set_sponsor_types
    @sponsor_types = SponsorType.includes(:sponsor_type_translations).order("sponsor_type_translations.title asc")
  end

  def set_organisations
    # sponsor type of 1 = org; set in seed
    @organizations = Sponsor.get_by_type_id(1)
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

end
