class Event < ActiveRecord::Base
  translates :title, :description

  has_many :event_translations
  accepts_nested_attributes_for :event_translations
  attr_accessible :start, :end, :sponsor_ids, :category_ids, :event_translations_attributes, :lat, :lon
  attr_accessor :locale

  has_many :event_sponsors
  has_many :event_categories
  has_many :sponsors, :through => :event_sponsors
  has_many :categories, :through => :event_categories

  validates :start, :end, :presence => true
  
  # will_paginate will get this many records per page
  self.per_page = 20
#TODO - need to get this function working
#  validate :date_comparison_validator
  validates_associated :event_translations
  
  scope :l10n , joins(:event_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n


  # get all events for a date
  def self.find_by_date(date, page)
    where("date(start)=?", date).paginate(:page => page).order("start ASC")
  end

  # get all events for a category
  def self.find_by_category(category_title, page)
    joins(:event_translations, :categories => :category_translations)
      .where('category_translations.title = ? and event_translations.locale = ? and category_translations.locale = ?', 
        category_title, I18n.locale, I18n.locale)
      .paginate(:page => page)
      .order('events.start asc, event_translations.title asc')
  end


 private
  
  # make sure the start date is < end date  
  def date_comparison_validator
    if (!self.start.blank? && !self.end.blank?) then
      errors.add(:start, 'is not a valid date/time') if ((DateTime.parse(self.start) rescue ArgumentError) == ArgumentError)
      errors.add(:end, 'is not a valid date/time') if ((DateTime.parse(self.end) rescue ArgumentError) == ArgumentError)
      errors.add(:end, 'must be after the Start date/time') if (DateTime.parse(self.start) >= DateTime.parse(self.end))
    end
  end
  
end


