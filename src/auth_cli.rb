$LOAD_PATH << File.join(File.dirname(__FILE__), "../src")
require 'auth'

# if being called from the cmd line with args
if !(ARGV[0].nil?)
  # setup the authentication server
  pwd_file = PasswordFile.new()
  auth     = Authentication.new(pwd_file)

  # grab the input and write out the output to stdout
  puts CommandLine.CalledWith(auth, ARGV)

end