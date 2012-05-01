class EventTranslation < ActiveRecord::Base
  attr_accessible :event_id, :title, :description, :locale, :picture_text, :building_name, :address
  belongs_to :event

  validates :title, :description, :locale, :presence => true
  # this will always call validation to fail due to the translations being 
  # created while the event is created.  probably way to fix
#  validates :event_id, :presence => true  
#  validates :title, :uniqueness => { :scope => :locale, :message => 'already exists'}

  default_scope order('locale ASC, title ASC')

	before_save :clean_text

private
	# look for tabs in strings and remove them
	def clean_text
		self.title.gsub! /\t/, ' ' if !self.title.nil?
		self.description.gsub! /\t/, ' ' if !self.description.nil?
		self.picture_text.gsub! /\t/, ' ' if !self.picture_text.nil?
		self.building_name.gsub! /\t/, ' ' if !self.building_name.nil?
		self.address.gsub! /\t/, ' ' if !self.address.nil?
	end
  
end
