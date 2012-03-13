class EventCategory < ActiveRecord::Base
  belongs_to :event
  belongs_to :category

  validates :event_id, :category_id, :presence => true

end
