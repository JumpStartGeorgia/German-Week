class Sponsor < ActiveRecord::Base
  translates :title, :description
  has_attached_file :logo,
        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
        :url => "/system/:attachment/:id/:style/:filename"

  has_many :sponsor_translations, :dependent => :destroy
  accepts_nested_attributes_for :sponsor_translations
  attr_accessible :sponsor_translations_attributes, :url, :logo, :event_ids
  attr_accessor :locale

  has_many :event_sponsors
  has_many :events, :through => :event_sponsors

  validates :url, :logo, :presence => true 
  validates_associated :sponsor_translations

  
  scope :l10n , joins(:sponsor_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n
end
