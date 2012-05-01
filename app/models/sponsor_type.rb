class SponsorType < ActiveRecord::Base
  translates :title

  has_many :sponsor_type_translations, :dependent => :destroy
  has_many :sponsors
  accepts_nested_attributes_for :sponsor_type_translations
  attr_accessible :id, :sponsor_type_translations_attributes
  attr_accessor :locale

  scope :l10n , joins(:sponsor_type_translations).where('locale = ?',I18n.locale)


  def self.get_all
		includes(:sponsor_type_translations)
		  .where("sponsor_type_translations.locale = :locale",
		    :locale => I18n.locale)
		  .order("sponsor_type_translations.title ASC")
  end
end
