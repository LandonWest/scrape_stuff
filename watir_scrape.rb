require 'watir'
require 'pry'

begin
  browser = Watir::Browser.new(:ff)

  browser.goto('http://www.google.com')
  text_field = browser.text_field(:name, 'q')
  text_field.value = 'Ruby on Rails'

  binding.pry

  link = browser.link(:href, 'http://rubyonrails.org/')
  link.click
rescue Exception => e
  puts e.message
  browser.close
end
