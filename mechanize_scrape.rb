require 'mechanize'
require 'pry'
require 'yaml'

browser = Mechanize.new

google = browser.get('http://www.google.com')
form = google.form_with(action: '/search')
text_field = form.field_with(name: 'q')
text_field.value = 'Ruby on Rails tutorials'
results_page = form.submit
puts "Total Links Found: #{results_page.links.count}"

# ror_page = results_page.link_with(text: 'Ruby on Rails').click
# puts ror_page.title
#
# binding.pry

result_links = results_page.search('#search h3.r a')
puts result_links.count
links = []

result_links.each do |link|
  url = link['href'].gsub('/url?=', '')
  links << { url: url, text: link.text }
end

File.open('tuts.yml', 'w+') do |f|
  f.write(links.to_yaml)
end
puts "done!"
