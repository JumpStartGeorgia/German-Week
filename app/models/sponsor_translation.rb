class SponsorTranslation < ActiveRecord::Base

  attr_accessible :sponsor_id, :title, :description, :address, :locale
  belongs_to :sponsor

  validates :title, :description, :locale, :presence => true
#  validates :address, :presence => true  # not required
  # this will always call validation to fail due to the translations being 
  # created while the sponsor is created.  probably way to fix
#  validates :sponsor_id, :presence => true  
  validates :title, :uniqueness => { :scope => :locale, :message => 'already exists'}

  default_scope order('locale ASC')
end
