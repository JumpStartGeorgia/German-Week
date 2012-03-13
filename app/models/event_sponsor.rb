class EventSponsor < ActiveRecord::Base
  belongs_to :event
  belongs_to :sponsor

  validates :event_id, :sponsor_id, :presence => true

end
