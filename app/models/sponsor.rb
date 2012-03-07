class Sponsor < ActiveRecord::Base
  translates :title, :description, :address

  attr_accessible :title, :description, :address, :url, :phone, :type, :locale, :event_ids
  attr_accessor :locale

  has_many :event_sponsors
  has_many :events, :through => :event_sponsors

  has_many :sponsor_translations
  
  scope :l10n , joins(:sponsor_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
