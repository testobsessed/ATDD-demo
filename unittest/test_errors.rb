#!ruby
require 'rubygems' # required to make gem-finding work. must be a better way
require 'test/unit'
require File.dirname(__FILE__) + '/../src/messages'


class TestErrs < Test::Unit::TestCase
  def test_can_retrieve_messages
    assert_equal "Account created", Messages.lookup(:success)
  end
end



