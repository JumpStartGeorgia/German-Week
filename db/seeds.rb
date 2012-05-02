# encoding: utf-8
=begin
# Locales **************************************************************************

Locale.destroy_all

Locale.create(:language => 'de' , :name => 'Deutsch')
Locale.create(:language => 'ka' , :name => 'ქართული')
Locale.create(:language => 'en' , :name => 'English')

# Pages **************************************************************************

PageTranslation.destroy_all
Page.destroy_all

page = Page.create(:name => 'contact')
page.page_translations.create(:locale => 'de', :title => 'Kontakt', :description => '...')
page.page_translations.create(:locale => 'ka', :title => 'დაგვიკავშირდეთ', :description => '...')
page.page_translations.create(:locale => 'en', :title => 'Contact', :description => '...')
page = Page.create(:name => 'disclaimer')
page.page_translations.create(:locale => 'de', :title => 'Haftungsausschluss', :description => '...')
page.page_translations.create(:locale => 'ka', :title => 'პასუხისმგებლობის შეზღუდვის განაცხადი', :description => '...')
page.page_translations.create(:locale => 'en', :title => 'Disclaimer', :description => '...')
page = Page.create(:name => 'ambassador')
page.page_translations.create(:locale => 'de', :title => 'Haftungsausschluss', :description => '...')
page.page_translations.create(:locale => 'ka', :title => 'პასუხისმგებლობის შეზღუდვის განაცხადი', :description => '...')
page.page_translations.create(:locale => 'en', :title => 'Disclaimer', :description => '...')
=end
# Sponsor Types **************************************************************************

SponsorTypeTranslation.destroy_all
SponsorType.destroy_all

sponsor_type = SponsorType.create(:id => 1)
sponsor_type.sponsor_type_translations.create(:locale => 'de', :title => 'Organisationen')
sponsor_type.sponsor_type_translations.create(:locale => 'ka', :title => 'ორგანიზაციები')
sponsor_type.sponsor_type_translations.create(:locale => 'en', :title => 'Organizations')
sponsor_type = SponsorType.create(:id => 2)
sponsor_type.sponsor_type_translations.create(:locale => 'de', :title => 'Sponsoren')
sponsor_type.sponsor_type_translations.create(:locale => 'ka', :title => 'სპონსორები')
sponsor_type.sponsor_type_translations.create(:locale => 'en', :title => 'Sponsors')
sponsor_type = SponsorType.create(:id => 3)
sponsor_type.sponsor_type_translations.create(:locale => 'de', :title => 'Partners')
sponsor_type.sponsor_type_translations.create(:locale => 'ka', :title => 'პარტნიორები')
sponsor_type.sponsor_type_translations.create(:locale => 'en', :title => 'Partners')

