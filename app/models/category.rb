class Category < ActiveRecord::Base
  translates :title

  attr_accessible :title, :locale
  attr_accessor :locale

  has_many :event_categories
  has_many :events, :through => :event_categories

  has_many :category_translations
  
  scope :l10n , joins(:category_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
