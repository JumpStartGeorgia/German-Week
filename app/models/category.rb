class Category < ActiveRecord::Base
  translates :title

#  attr_accessible :title, :locale
  attr_accessor :locale

  has_many :category_translations, :dependent => :destroy
  accepts_nested_attributes_for :category_translations
  attr_accessible :category_translations_attributes

  has_many :event_categories
  has_many :events, :through => :event_categories

  validates_associated :category_translations
  
  scope :l10n , joins(:category_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n


  def self.get_all
		includes(:category_translations)
		  .where("category_translations.locale = :locale",
		    :locale => I18n.locale)
		  .order("category_translations.title ASC")
  end
  
end
