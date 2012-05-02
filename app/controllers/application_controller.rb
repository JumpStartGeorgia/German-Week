class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :set_organisations
  before_filter :init_gon
  before_filter :set_categories
  before_filter :set_sponsor_types
  
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
    gon.lat = 42.083278671742
		gon.lon = 43.869205165667
    gon.locale = params[:locale]
    gon.header_slider_data = self.slider_data 'public/assets/images/header/'
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
    data = [];
    @organizations.each do |org|
      if !org.logo_file_name.nil?
        data << {'image_url' => '/assets/images/sponsors/' + org.logo_file_name, 'url' => sponsor_path(org), 'title' => org.title}
			end
		end
		data
  end

  def slider_data (pathname)
  # pathname = 'public/assets/images/header/';
    extensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    images = [];

    if !File.directory?(pathname)
      return []
    end

    Dir.foreach(pathname) do |f|
      if !extensions.include? File.extname(f)[1..4]
        next
      end
      images.push '/assets/images/header/' + f
    end

    max = images.count
    randoms = Set.new();
    loop do
      randoms << Random.rand(max)
      if randoms.size == max
        break
      end
    end

    random_images = [];
#    images.each_with_index do |img, i|
#      if randoms.include? i
#        random_images.push img
#      end
#    end

    randoms.each_with_index do |rand, i|
      random_images[rand] = {'image_url' => images[i], 'url' => false};
    end

    random_images

  end

end
