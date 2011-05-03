Given /^there are no accounts in the accounts database$/ do
  $pwd_file.delete
  $auth.load_users
end

Then /^the accounts database should contain an account "([^"]*)" \/ "([^"]*)" in state "([^"]*)"$/ do |username, password, state|
  $pwd_file.user_exists?(username, password, state)
end

When /^I attempt to create an account with a username that already exists$/ do
  When %[I create an account with username "xyzfoo" and password "p@ssw0rd"]
  And %[I create an account with username "xyzfoo" and password "p@ssw0rd"]
end
