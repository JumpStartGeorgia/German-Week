class Event < ActiveRecord::Base
  translates :title, :description

  attr_accessible :title, :description, :event_date, :start_time, :end_time, :locale, :sponsor_ids, :category_ids
  attr_accessor :locale

  has_many :event_sponsors
  has_many :event_categories
  has_many :sponsors, :through => :event_sponsors
  has_many :categories, :through => :event_categories

  has_many :event_translations
  
  scope :l10n , joins(:event_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n

  after_initialize :set_default_values

  
  
  private

  def set_default_values
    self.event_date ||= '2012-05-14'
  end
end
