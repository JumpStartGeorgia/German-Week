class Event < ActiveRecord::Base
  translates :title, :description

  has_many :event_translations
  accepts_nested_attributes_for :event_translations
  attr_accessible :start, :end, :sponsor_ids, :category_ids, :event_translations_attributes
  attr_accessor :locale

  has_many :event_sponsors
  has_many :event_categories
  has_many :sponsors, :through => :event_sponsors
  has_many :categories, :through => :event_categories

  validates :start, :end, :presence => true
#TODO - need to get this function working
#  validate :date_comparison_validator
  validates_associated :event_translations
  
  scope :l10n , joins(:event_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n

  def self.search(search, category = false)
    if search && search.length > 0
      if category
        joins(:categories => :category_translations).where("category_translations.title = ?", search)
      else
        joins(:event_translations).where("event_translations.title LIKE ? OR event_translations.description LIKE ?", '%' + search + '%', '%' + search + '%').uniq
      end
    else
      nil
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


