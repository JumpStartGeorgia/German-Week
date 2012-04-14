class EventSponsor < ActiveRecord::Base
  belongs_to :event
  attr_accessible :event_id, :name, :logo_path, :url

  validates :name, :logo_path, :url,  :presence => true

end
