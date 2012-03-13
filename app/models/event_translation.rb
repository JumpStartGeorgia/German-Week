class EventTranslation < ActiveRecord::Base
  attr_accessible :event_id, :title, :description, :locale
  belongs_to :event

  validates :title, :description, :locale, :presence => true
  # this will always call validation to fail due to the translations being 
  # created while the event is created.  probably way to fix
#  validates :event_id, :presence => true  
  validates :title, :uniqueness => { :scope => :locale, :message => 'already exists'}

  default_scope order('locale ASC')
end
