class Event < ActiveRecord::Base
  translates :title, :description

  has_many :event_translations, :dependent => :destroy
  has_many :event_sponsors, :dependent => :destroy
  has_many :sponsors, :through => :event_sponsors
  has_many :event_categories, :dependent => :destroy
  has_many :categories, :through => :event_categories

  accepts_nested_attributes_for :event_translations
  attr_accessible :start, :end, :sponsor_ids, :category_ids, :lat, :lon, :address, :event_translations_attributes
  attr_accessor :locale  

  validates :start, :end, :presence => true

  # reverse geocoding by lon & lat
  geocoded_by :address
  reverse_geocoded_by :lat, :lon
  before_save  :reverse_geocode
  
  # will_paginate will get this many records per page
  self.per_page = 5
#TODO - need to get this function working
#  validate :date_comparison_validator
  validates_associated :event_translations
  
  scope :l10n , joins(:event_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n

  # search 
  def self.search(search, category, page)
    if search && search.length > 0
      if category && category.length > 0 && category != 'all'
        joins({:categories => :category_translations}, :event_translations)
          .where("event_translations.locale = ? AND category_translations.title = ? AND (event_translations.title LIKE ? OR event_translations.description LIKE ?)", 
            I18n.locale, category, '%' + search + '%', '%' + search + '%')
          .paginate(:page => page).order("start ASC")
      elsif !category || category == 'all'
        joins(:event_translations)
          .where("event_translations.locale = ? AND (event_translations.title LIKE ? OR event_translations.description LIKE ?)", 
            I18n.locale, '%' + search + '%', '%' + search + '%')
          .paginate(:page => page).order("start ASC")
      end
    else
      if category && category.length > 0 && category != 'all'
        joins({:categories => :category_translations}, :event_translations)
          .where("event_translations.locale = ? AND category_translations.title = ?", I18n.locale, category)
          .paginate(:page => page).order("start ASC")
      else
        nil
      end
    end
  end

  # get all events for a date
  def self.find_by_date(date, page)
    if date
      where("date(start)=?", date).paginate(:page => page).order("start ASC")
    else
      nil
    end
  end

  # get all events for a category
  def self.find_by_category(category_title, page)
    if category_title
      joins(:event_translations, :categories => :category_translations)
        .where('category_translations.title = ? and event_translations.locale = ? and category_translations.locale = ?', 
          category_title, I18n.locale, I18n.locale)
        .paginate(:page => page)
        .order('events.start asc, event_translations.title asc')
    else
      nil
    end
  end

  # get events for map
  def self.find_for_map(type, dayorcategory, day)
    if !type.nil? && !dayorcategory.nil? && !day.nil?
  		if type == "day"	
  			where("(DATE_FORMAT(start,'%Y-%m-%d') <= DATE_FORMAT(?,'%Y-%m-%d')) AND (DATE_FORMAT(end,'%Y-%m-%d') >= DATE_FORMAT(?,'%Y-%m-%d'))",
  			  dayorcategory, dayorcategory)
  		elsif type == "category" 		
  			joins(:event_translations, :categories => :category_translations)
  			  .where('category_translations.title = ? and event_translations.locale = ? and category_translations.locale = ?', 
  			    dayorcategory, I18n.locale, I18n.locale)				        
  		elsif type == "daycategory"
  			joins(:event_translations, :categories => :category_translations)
  			  .where("category_translations.title = ? and event_translations.locale = ? and category_translations.locale = ? and (DATE_FORMAT(start,'%Y-%m-%d') <= DATE_FORMAT(?,'%Y-%m-%d')) AND (DATE_FORMAT(end,'%Y-%m-%d') >= DATE_FORMAT(?,'%Y-%m-%d'))", 
  			    dayorcategory, I18n.locale, I18n.locale, day, day)
      else
        return nil
  		end
    else
      return nil
		end
  end

  # get events for ics download
  def self.find_for_ics(type, typespec)
    if !type.nil? && !typespec.nil?
    	case type
    		when "event" 
    			find typespec
    		when "day" 
    			where("DATE_FORMAT(start,'%Y-%m-%d') <= DATE_FORMAT(?,'%Y-%m-%d') AND DATE_FORMAT(end,'%Y-%m-%d') >= DATE_FORMAT(?,'%Y-%m-%d')",
  				 typespec, typespec)  	  			
    		when "category" 
    			joins(:event_translations, :categories => :category_translations)
  					.where("category_translations.title = ? and event_translations.locale = ? and category_translations.locale = ?", 
  					  typespec, I18n.locale, I18n.locale)				
  			when "sponsor"
  				joins(:event_translations, :sponsors => :sponsor_translations)
  					.where("sponsor_translations.sponsor_id = ? and event_translations.locale = ? and sponsor_translations.locale = ?", 
  					  typespec, I18n.locale, I18n.locale)
    		else 
    		  return nil
    	end
    else
      return nil
    end
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





