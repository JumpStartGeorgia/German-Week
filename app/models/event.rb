class Event < ActiveRecord::Base
  translates :title, :description

  attr_accessible :title, :locale
  attr_accessor :locale

  has_many :event_sponsors
  has_many :event_tags
  has_many :sponsors, :through => :event_tags
  has_many :tags, :through => :event_tags

  has_many :event_translations
  
  scope :l10n , joins(:event_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
