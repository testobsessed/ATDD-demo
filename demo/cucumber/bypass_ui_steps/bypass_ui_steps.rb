$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "../support"))
require "env"

When /^I create an account with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $last_message = Messages.lookup($auth.create(username, password))
end

When /^I attempt to login with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $last_message = Messages.lookup($auth.login(username, password))
end

Then /^the system response should be "([^"]*)"$/ do |message|
  $last_message.should == message
end



