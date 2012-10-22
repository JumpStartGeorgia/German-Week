class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_organisations
  before_filter :set_categories
  before_filter :set_sponsor_types
  before_filter :init_gon

  def set_locale
    @locales = Locale.order("language asc")
		# see if locale is valid
		valid = false
		if !params[:locale].nil?
			@locales.each do |l|
				if l.language.downcase == params[:locale].downcase
					valid = true
					break
				end
			end
			if valid
			  I18n.locale = params[:locale] if params[:locale]
			else
			  I18n.locale = I18n.default_locale
			  params[:locale] = I18n.default_locale
			end
		end
  end

  # pre-load gon so js does not through errors on pages that do not use gon
  def init_gon
    lang = I18n.locale.to_s == 'ka' ? 'ka' : 'en'
    gon.tile_url = "http://tile.mapspot.ge/#{lang}/{z}/{x}/{y}.png"
    gon.attribution = 'Map data &copy; <a href="http://jumpstart.ge" target="_blank">JumpStart Georgia</a>'
    gon.map_id = 'map'
    gon.zoom = 14
    gon.max_zoom = 18
    gon.lat = 41.643455883245
		gon.lon = 41.640045213257
    gon.locale = params[:locale]
    gon.header_slider_data = self.slider_data
    gon.footer_slider_data = self.footer_slider_data
  end

  def set_categories
    @categories = Category.get_all
  end

  def set_sponsor_types
    @sponsor_types = SponsorType.get_all
  end

  def set_organisations
    # sponsor type of 1 = org; set in seed
    @organizations = Sponsor.get_by_type_id(1)
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def footer_slider_data
		orgs = []	# some organizations may not have logos, so need this array to track those with
    random_images = []

    @organizations.each do |org|
      if !org.logo_file_name.nil?
        orgs << org
			end
		end


    if !orgs.nil? && orgs.length > 0
      randoms = Set.new()
      while randoms.length < orgs.length
        randoms << Random.rand(orgs.length)
      end

      randoms.each_with_index do |rand, i|
        random_images[rand] = {'img_src' => orgs[i].logo.url, 'url' => sponsor_path(orgs[i]), 'title' => orgs[i].title}
      end
    end

    random_images
  end

  def slider_data
    images = ImageHeader.all
    random_images = []

    if images.nil? || images.length == 0
      return
    end

    randoms = Set.new()
    while randoms.length < images.length
      randoms << Random.rand(images.length)
    end

    randoms.each_with_index do |rand, i|
      random_images[rand] = {'img_src' => images[i].image.url}#, 'url' => false};
    end

    random_images
  end

end
