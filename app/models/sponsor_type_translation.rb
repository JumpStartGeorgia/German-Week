class SponsorTypeTranslation < ActiveRecord::Base
  attr_accessible :sponsor_type_id, :title, :locale
  belongs_to :sponsor_type

  validates :title, :locale, :presence => true
  # this will always call validation to fail due to the translations being 
  # created while the sponsor type is created.  probably way to fix
#  validates :sponsor_type_id, :presence => true  

	before_save :clean_text

private
	# look for tabs in strings and remove them
	def clean_text
		self.title.gsub! /\t/, ' '
	end
  

end
