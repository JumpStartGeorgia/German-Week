# encoding: utf-8
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
sponsor_type.sponsor_type_translations.create(:locale => 'de', :title => 'Partner')
sponsor_type.sponsor_type_translations.create(:locale => 'ka', :title => 'პარტნიორები')
sponsor_type.sponsor_type_translations.create(:locale => 'en', :title => 'Partners')
=begin

# Image Headers **************************************************************************

ImageHeader.destroy_all
ImageHeader.create(:id => 1, :image_file_name => '1.jpg', :image_file_size => 156380, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 2, :image_file_name => '2.jpg', :image_file_size => 222949, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 3, :image_file_name => '3.jpg', :image_file_size => 60373, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 4, :image_file_name => '4.jpg', :image_file_size => 249193, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 5, :image_file_name => '5.jpg', :image_file_size => 78941, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 6, :image_file_name => '6.jpg', :image_file_size => 127443, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 7, :image_file_name => '7.jpg', :image_file_size => 224318, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 8, :image_file_name => '8.jpg', :image_file_size => 272163, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 9, :image_file_name => '9.jpg', :image_file_size => 154077, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 10, :image_file_name => '10.jpg', :image_file_size => 201055, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 11, :image_file_name => '11.jpg', :image_file_size => 232041, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 12, :image_file_name => '12.jpg', :image_file_size => 190495, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 13, :image_file_name => '13.jpg', :image_file_size => 183854, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 14, :image_file_name => '14.jpg', :image_file_size => 193033, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 15, :image_file_name => '15.jpg', :image_file_size => 107770, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 16, :image_file_name => '16.jpg', :image_file_size => 249657, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 17, :image_file_name => '17.jpg', :image_file_size => 112268, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 18, :image_file_name => '18.jpg', :image_file_size => 159017, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 19, :image_file_name => '19.jpg', :image_file_size => 194964, :image_content_type => 'image/jpeg')
ImageHeader.create(:id => 20, :image_file_name => '44.jpg', :image_file_size => 126781, :image_content_type => 'image/jpeg')


=end
