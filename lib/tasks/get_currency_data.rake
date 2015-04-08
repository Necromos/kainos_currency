require 'open-uri'

namespace :get_currency_data do
  desc 'Get all currencies average data from last month'
  task :all_last_month => :environment do
    dir_file = open('http://www.nbp.pl/kursy/xml/dir.txt')
    @correct, @incorrect = 0, 0
    last = "a001z070102"
    dir_file.each_line do |line|
      if line[/\A[a][0-9]{3}z(07|08|09|10|11|12|13|14)/]
        if last[-4..-3] != line[-6..-5]
          save_data last
        end
        last = line.gsub("\n","").gsub("\r","")
      end
    end
    save_data last
    puts "Records saved correctly: " + @correct.to_s
    puts "Records saved incorrectly: " + @incorrect.to_s
  end

  desc 'Get all currencies data (IT WILL BE LONG PROCESS)'
  task :all => :environment do
    dir_file = open('http://www.nbp.pl/kursy/xml/dir.txt')
    @correct, @incorrect = 0, 0
    dir_file.each_line do |line|
      if line[/\A[a][0-9]{3}z(07|08|09|10|11|12|13|14)/]
        line = line.gsub("\n","").gsub("\r","")
        save_data line
      end
    end
    save_data last
    puts "Records saved correctly: " + @correct.to_s
    puts "Records saved incorrectly: " + @incorrect.to_s
  end

  private
    def save_data(name)
      uri = "http://www.nbp.pl/kursy/xml/"+ name + ".xml"
      puts "Current file: " + uri
      doc = Nokogiri::HTML(open(uri))
      date = doc.xpath('//data_publikacji').text.to_datetime.strftime("%Y-%m-%d")
      currencies = doc.xpath('//pozycja')
      currencies.each do |currency|
        record = Currency.new
        record.name = currency.xpath('nazwa_waluty').text
        record.code = currency.xpath('kod_waluty').text
        record.conversion_rate = currency.xpath('przelicznik').text.to_i
        record.average_exchange_rate = currency.xpath('kurs_sredni').text.gsub(",",".").to_f
        record.date = date
        record.save ? @correct += 1 : @incorrect += 1
      end
    end
end
