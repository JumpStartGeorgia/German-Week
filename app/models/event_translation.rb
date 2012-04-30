class EventTranslation < ActiveRecord::Base
  attr_accessible :event_id, :title, :description, :locale, :picture_text
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
		self.title.gsub! /\t/, ' '
		self.description.gsub! /\t/, ' '
		self.picture_text.gsub! /\t/, ' '
	end
  
end
