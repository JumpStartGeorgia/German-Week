class CategoryTranslation < ActiveRecord::Base

  attr_accessible :category_id, :title, :locale
  belongs_to :category

  validates :title, :locale, :presence => true
  # this will always call validation to fail due to the translations being 
  # created while the category is created.  probably way to fix
#  validates :category_id, :presence => true  
  validates :title, :uniqueness => { :scope => :locale, :message => 'already exists'}

  default_scope order('locale ASC, title ASC')
end
