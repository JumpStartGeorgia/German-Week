class Event < ActiveRecord::Base
  has_many :event_sponsors, :dependent => destroy
end
