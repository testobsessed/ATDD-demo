#!ruby
require 'rubygems' # required to make gem-finding work. must be a better way
require 'test/unit'
require File.dirname(__FILE__) + '/../src/password'

class TestPassword < Test::Unit::TestCase
  def test_validate_password_returns_true_when_all_conventions_met
    assert Password.valid?("p@sSw0rd")
  end
  
  def test_validate_password_returns_false_when_password_less_than_6_chars
    assert !Password.valid?("p@sSw0")
  end
  
  def test_validate_password_returns_true_when_password_7_chars
    assert Password.valid?("p@sSw0r")
  end

  def test_validate_password_returns_false_when_password_more_than_20_chars
    assert !Password.valid?("p@sSw0rd" + "A"*13)
  end
  
  def test_validate_password_returns_false_when_password_missing_special_characters
    assert !Password.valid?("pasSw0rd")
  end
  
  def test_validate_password_returns_false_when_password_has_invalid_characters
    assert !Password.valid?("p@sS'w0rd")
  end
  
  def test_valid_returns_false_when_missing_lower_letter
    assert !Password.valid?("P@SSW0RD")
  end
  
  def test_valid_returns_false_when_missing_upper_letter
    assert !Password.valid?("p@ssw0rd")
  end
  
  def test_validate_password_returns_false_when_password_missing_number
    assert !Password.valid?("p@sSword")
  end

end