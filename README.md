#**Kainos-CurrencyApp**
##Author: Przemysław Królik
-----
###Intro

App made as next recruiting process step for position of Trainee Software Engineer commissioned by Kainos company in 2015.

###Technologies used

 - Ruby (on Rails, [Nokogiri](http://www.nokogiri.org/))
 - JavaScript (jQuery, d3js)
 - Bootstrap ([Bootstrap Datepicker](http://eternicode.github.io/bootstrap-datepicker/))

###Configuration steps

 1. `bundle install`
 2. `rake db:migrate`
 3. `rake get_currency_data:all_last_month` for only last day of month data or `rake get_currency_data:all` to get all records
 4. `rails s` and open in browser `localhost:3000`
