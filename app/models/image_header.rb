class ImageHeader < ActiveRecord::Base
  has_attached_file :image,
        :path => "/system/header/:attachment/:id/:style/:filename",
        :url => "/system/header/:attachment/:id/:style/:filename"

  attr_accessible :image, :image_file_name, :image_file_size, :image_content_type, :id

  validates :image, :presence => true

  # will_paginate will get this many records per page
  self.per_page = 4


end
