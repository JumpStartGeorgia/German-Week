class Tag < ActiveRecord::Base
  translates :title

  attr_accessible :title, :locale
  attr_accessor :locale

  has_many :event_tags, :dependent => destroy
  has_many :events, :through => :event_tags

  has_many :tag_translations
  
  scope :l10n , joins(:tag_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
