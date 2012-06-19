$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "../src"))
require "auth"
SRC_PATH = "#{File.dirname(__FILE__)}/../../src/auth_cli.rb"

require "rubygems"
require 'spec/expectations'


$pwd_file = PasswordFile.new
$auth = Authentication.new($pwd_file)
$last_message = ""

require "general_steps"

