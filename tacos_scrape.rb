require 'mechanize'
require 'pry'
require 'yaml'

browser = Mechanize.new

yelp = browser.get('http://www.yelp.com')
form = yelp.form_with(action: '/search')
text_field = form.field_with(name: 'find_desc')
text_field.value = 'tacos'
text_field = form.field_with(name: 'find_loc')
text_field.value = 'Salt Lake City'
results_page = form.submit

results = results_page.search('.natural-search-result')
puts "Total Results on This Page: #{results.count}"

restaurants = []

results.each do |result|
  name = result.search('h2.search-result-title').text.gsub("\n", '').strip
  address = result.search('address').text.gsub("\n", '').strip
  phone = result.search('.biz-phone').text.gsub("\n", '').strip
  restaurants << { name: name, address: address, phone: phone }

end

File.open('tacos.yml', 'w+') do |f|
  f.write(restaurants.to_yaml)
end
