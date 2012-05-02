module ApplicationHelper
  
  # determine if the current request is html (i.e., not pdf)
  def is_html
    !params[:format].nil? && params[:format] == "pdf" ? false : true
  end

  # get the host url
  def host_url
    proto = request.env['SERVER_PROTOCOL'].downcase.index("https").nil? ? "http" : "https"
    return "#{proto}://#{request.env['HTTP_HOST']}"
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def format_date(date)
    date.strftime('%Y/%m/%d') if !date.nil?
  end

  def format_datetime(dt)
    dt.strftime('%Y/%m/%d %H:%M') if !dt.nil?
  end

  def format_time(time)
    time.strftime('%H:%M') if !time.nil?
  end
  
  def pretty_time(dt_start, dt_end=nil)
    if !dt_start.nil?
      if dt_end.nil?
        # only have start date
        I18n.l dt_start, :format => :short
      elsif format_date(dt_start) == format_date(dt_end)
				# have same dates, different times
        "#{I18n.l dt_start, :format => :short} - #{I18n.l dt_end, :format => :time_only}"
			else
        "#{I18n.l dt_start, :format => :short} - #{I18n.l dt_end, :format => :short}"
      end
    end
  end

	# add http to url if not present
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

=begin
  def multi_language_form(destination)
     destination = controller.controller_name.to_s + '/' + destination 
     html = ""
     html << multi_language_form_tab
     html << render(:partial => destination)
     I18n.locale = params[:locale]
     html.html_safe
  end
  
  def multi_language_form_tab
    html = ""
    html << '<ul class="select-form-language">'
    @locales.each do |locale|
      I18n.locale.to_s == locale.language ? ts = ' tab-selected' : ts = '' 
      javascript_function =  "$('.multilanguage').hide();"
      javascript_function << "$('#form-#{locale.language}').show();"
      html << "<li id=\"tab-#{locale.language}\" class=\"multilanguage-menu#{ts}\" >"
      html << link_to_function(locale.name, javascript_function)
      html << "</li>" 
    end
    html << "</ul>"
    html.html_safe
  end
=end  
end
