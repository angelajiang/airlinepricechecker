require 'rubygems'
require 'watir-webdriver'
require 'pry'



def hipmunk(location_from, location_to, target_leave_date, target_return_date)
  browser = Watir::Browser.new
  browser.goto 'http://www.hipmunk.com/'
  enter_flight_data(browser, location_from, location_to, target_leave_date, target_return_date)
  scape_data(browser)
end

def enter_flight_data(browser, location_from, location_to, target_leave_date, target_return_date)
  browser.div(:class => "tab-flight").click
  browser.text_field(:id => 'date0-flight').set target_leave_date
  browser.text_field(:id=> 'date1-flight').set target_return_date

  browser.text_field(:id => 'fac1flight').set location_from
  browser.text_field(:id=> 'fac2flight').set location_to
  browser.button(:text => 'Search', :index => 1).click
end

def scape_data(browser)
  browser.element(:class => "full-name", :index => 1).when_present.hover
  (1..100).step(2) do |x|
    begin
      price = browser.element(:class => "price", :index => x).text
      browser.element(:class => "full-name", :index => x).hover
      flight = browser.element(:class => "flightnum").text
      puts Time.now.to_s + " | #{flight} | #{price}"
      browser.driver.execute_script("window.scrollBy(0,130)")
    rescue Exception => e
    end
  end
end




hipmunk("CHI - Chicago, IL (Area)", "NYC - New York City, NY (Area)", "Nov 19", "Nov 26")