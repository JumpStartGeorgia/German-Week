# Locales **************************************************************************

ActiveRecord::Base.connection.execute("TRUNCATE locales") 

Locale.create(:language => 'de' , :name => 'Deutsch')
Locale.create(:language => 'ka' , :name => 'ქართული')
Locale.create(:language => 'en' , :name => 'English')

