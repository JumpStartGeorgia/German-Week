class Sponsor < ActiveRecord::Base
  translates :title, :description, :address
  has_attached_file :logo,
        :path => "/sponsor/:attachment/:id/:style/:filename",
        :storage => :s3,
        :url => ":s3_domain_url",
        :bucket => ENV['S3_BUCKET'],
        :s3_credentials => S3_CREDENTIALS

  has_many :sponsor_translations, :dependent => :destroy
  belongs_to :sponsor_type
  accepts_nested_attributes_for :sponsor_translations
  attr_accessible :sponsor_translations_attributes, :sponsor_type_id, :url, :logo, :event_ids, :email, :phone, :fax
  attr_accessor :locale

  has_many :event_sponsors
  has_many :events, :through => :event_sponsors

  validates :url, :sponsor_type_id, :presence => true 
  validates_associated :sponsor_translations

  
  scope :l10n , joins(:sponsor_translations).where('locale = ?',I18n.locale)
  scope :by_title , order('title').l10n

  # will_paginate will get this many records per page
  self.per_page = 4

  def self.get_by_type(sponsor_type, page)
    if !sponsor_type.nil?
      includes(:sponsor_translations, {:sponsor_type => :sponsor_type_translations})
        .where("sponsor_translations.locale = :locale and sponsor_type_translations.locale = :locale and sponsor_type_translations.title = :type",
          :locale => I18n.locale, :type => sponsor_type)
				.paginate(:page => page)
        .order("sponsor_translations.title ASC")
    else
      return nil
    end
  end

  def self.get_all(page)
		includes(:sponsor_translations)
		  .where("sponsor_translations.locale = :locale",
		    :locale => I18n.locale)
			.paginate(:page => page)
		  .order("sponsor_translations.title ASC")
  end
  
  def self.get_by_type_id(sponsor_type_id)
    if !sponsor_type_id.nil?
      includes(:sponsor_translations)
        .where("sponsor_translations.locale = :locale and sponsors.sponsor_type_id = :type_id",
          :locale => I18n.locale, :type_id => sponsor_type_id)
        .order("sponsor_translations.title ASC")
    else
      return nil
    end
  end
  

end
