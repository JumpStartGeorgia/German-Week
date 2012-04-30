class PageTranslation < ActiveRecord::Base
  attr_accessible :page_id, :title, :description, :locale
  belongs_to :page

  validates :title, :description, :locale, :presence => true
  # this will always call validation to fail due to the translations being 
  # created while the page is created.  probably way to fix
#  validates :page_id, :presence => true  

	before_save :clean_text

private
	# look for tabs in strings and remove them
	def clean_text
		self.title.gsub! /\t/, ' '
		self.description.gsub! /\t/, ' '
	end
  
end
