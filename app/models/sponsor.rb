class Sponsor < ActiveRecord::Base
  has_many :event_sponsors
  
end
