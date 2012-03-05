class Sponsor < ActiveRecord::Base
  has_many :event_sponsors
  has_many :events, :through => :event_sponsors
end
