# encoding: utf-8
# Locales **************************************************************************

ActiveRecord::Base.connection.execute("TRUNCATE locales") 

Locale.create(:language => 'de' , :name => 'Deutsch')
Locale.create(:language => 'ka' , :name => 'ქართული')
Locale.create(:language => 'en' , :name => 'English')

# Pages **************************************************************************

ActiveRecord::Base.connection.execute("TRUNCATE pages") 

page = Page.create(:name => 'contact')
page.page_translations.create(:locale => 'de', :title => 'Kontakt', :description => '...')
page.page_translations.create(:locale => 'ka', :title => 'დაგვიკავშირდეთ', :description => '...')
page.page_translations.create(:locale => 'en', :title => 'Contact', :description => '...')
page = Page.create(:name => 'disclaimer')
page.page_translations.create(:locale => 'de', :title => 'Haftungsausschluss', :description => '...')
page.page_translations.create(:locale => 'ka', :title => 'პასუხისმგებლობის შეზღუდვის განაცხადი', :description => '...')
page.page_translations.create(:locale => 'en', :title => 'Disclaimer', :description => '...')

