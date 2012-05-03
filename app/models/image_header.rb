class ImageHeader < ActiveRecord::Base
  has_attached_file :image,
        :path => "/header/:attachment/:id/:style/:filename",
        :storage => :s3,
        :url => ":s3_domain_url",
        :bucket => ENV['S3_BUCKET_NAME'],
        :s3_credentials => S3_CREDENTIALS

  attr_accessible :image, :image_file_name, :image_file_size, :image_content_type, :id

  validates :image, :presence => true 

  # will_paginate will get this many records per page
  self.per_page = 4


end
