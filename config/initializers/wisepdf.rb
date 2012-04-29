Wisepdf::Configuration.configure do |c|
	c.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if Rails.env.production? 
end
