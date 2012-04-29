class SponsorType < ActiveRecord::Base
  translates :title

  has_many :sponsor_type_translations, :dependent => :destroy
  has_many :sponsors
  accepts_nested_attributes_for :sponsor_type_translations
  attr_accessible :id, :sponsor_type_translations_attributes
  attr_accessor :locale

  scope :l10n , joins(:sponsor_type_translations).where('locale = ?',I18n.locale)


end
