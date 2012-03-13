class Sponsor < ActiveRecord::Base
  translates :title, :description, :address

  has_many :sponsor_translations
  accepts_nested_attributes_for :sponsor_translations
  attr_accessible :sponsor_translations_attributes, :url, :phone, :type, :event_ids
  attr_accessor :locale

  has_many :event_sponsors
  has_many :events, :through => :event_sponsors

#  validates :url, :phone, :type, :presence => true  # not required
  validates_associated :sponsor_translations

  
  scope :l10n , joins(:sponsor_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
