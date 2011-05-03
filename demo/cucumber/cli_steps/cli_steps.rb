$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "../support"))
require "env"

When /^I create an account with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $last_message = (`ruby #{SRC_PATH} create #{username} #{password}`).strip
end

When /^I attempt to login with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  $last_message = (`ruby #{SRC_PATH} login #{username} #{password}`).strip
end

Then /^the system response should be "([^"]*)"$/ do |message|
  $last_message.should == message
end