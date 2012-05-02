=begin
PDFKit.configure do |config|       
	config.wkhtmltopdf = Rails.root.join('vendor', 'bin', 'wkhtmltopdf-amd64').to_s if Rails.env.production?  
end  
=end
