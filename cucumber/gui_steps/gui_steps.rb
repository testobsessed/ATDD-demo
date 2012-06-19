$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "../support"))
require "env"
require "gui_steps/login_page"

gem "selenium-client"
require "selenium/client"


# "before all"
selenium_driver = Selenium::Client::Driver.new \
  :host => "localhost",
  :port => 4444,
  :browser => "*firefox",
  :url => "http://localhost:9393",
  :timeout_in_second => 60
selenium_driver.start_new_browser_session
selenium_driver.window_maximize
selenium_driver.set_speed(1000)
$app = LoginPage.new(selenium_driver)


# "after all"
at_exit do
  selenium_driver.close_current_browser_session
end

When /^I create an account with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $app.create(username, password)
end

When /^I attempt to login with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $app.login(username, password)
end

Then /^the system response should be "([^"]*)"$/ do |message|
  $app.get_message.should == message
end