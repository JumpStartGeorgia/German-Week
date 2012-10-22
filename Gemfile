source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem "mysql2", "~> 0.3.11" # this gem works better with utf-8
gem "capistrano", "~> 2.12.0" # to deploy to server

gem 'jquery-rails', '1.0.19'
gem 'devise', '2.0.4'
gem 'formtastic', '2.1.1'
gem 'globalize3', '0.2.0'
gem 'psych', '1.2.2' # yaml parser - default psych in rails has issues

gem 'icalendar', '1.1.6' # icalendar for events export

gem 'will_paginate', '3.0.3' # pagination
gem 'gon', '2.2.2' # push data into js
gem "pdfkit", "~> 0.5.2" # generate pdfs

gem "geocoder", "~> 1.1.1"
gem "paperclip", "~> 3.0" # upload images
#gem 'aws-s3', "~> 0.6.2" # save uploaded images to amazon s3
#gem 'aws-sdk', "~> 1.4.1"
gem "twitter-bootstrap-rails"
gem "i18n-js", "~> 2.1.2" # to show translations in javascript
gem "fancybox-rails", "~> 0.1.4"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
#	gem "asset_sync", "~> 0.4.1"
  gem 'sass-rails', '3.1.4'
  gem 'coffee-rails'
  gem 'execjs'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier'
  gem 'twitter-bootstrap-rails'
end

group :development do
	# only need this in dev, on production we use the file in the bin folder
	gem "wkhtmltopdf-binary", "~> 0.9.5.3" # generate pdfs
	gem "taps"
end
