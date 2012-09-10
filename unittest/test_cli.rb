#!ruby
require 'rubygems' # required to make gem-finding work. must be a better way
require 'test/unit'
require 'flexmock/test_unit'
require File.dirname(__FILE__) + '/../src/auth_cli'


class TestCmd < Test::Unit::TestCase
  attr :auth
  
  def setup
    @auth = flexmock("Authentication")
  end

  def test_command_sent_to_auth_object
    @auth.should_receive(:create).once
    return_code = CommandLine.CalledWith(@auth, ["create"])
  end
  
  def test_undefined_command_returns_error_message
    return_code = CommandLine.CalledWith(@auth, ["nosuchcommand"])
    assert_equal "Auth Server: unknown command 'nosuchcommand'", return_code
  end
end



