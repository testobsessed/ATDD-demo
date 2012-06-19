#!ruby
require 'rubygems' # required to make gem-finding work. must be a better way
require 'test/unit'
require 'flexmock/test_unit'
require File.dirname(__FILE__) + '/../src/auth'


class TestAuth < Test::Unit::TestCase  
  
  attr :auth
  
  def setup
    # using mocks to avoid polluting real pwds file with test data
    pwd_file = flexmock("passwordfile")
    pwd_file.should_receive(:get_users).and_return({})
    pwd_file.should_receive(:save).and_return({})
    @auth = Authentication.new(pwd_file)
  end
  
  def test_valid_user_can_log_in
    @auth.create("sam", "A0&daaa")
    return_code = @auth.login("sam", "A0&daaa")
    assert @auth.get_user("sam").logged_in?, "Expected user should be logged in"
    assert_equal :logged_in, return_code
  end
  
  def test_auth_return_code_is_access_denied_if_login_fails
    return_code = @auth.login("aasdjfj", "")
    assert_equal :access_denied, return_code
  end
  
  def test_account_exists_returns_true_if_account_exists_with_username
    @auth.create("fred", "F0&blee")
    assert @auth.account_exists?("fred")
  end
  
  def test_account_exists_returns_false_if_no_account_with_username
    assert !@auth.account_exists?("foo")
  end
  
  def test_create_user_adds_new_user_to_list_with_user_data_and_returns_success
    assert !@auth.account_exists?("newacc")
    return_code = @auth.create("newacc", "D3f&lte")
    assert @auth.account_exists?("newacc")
    assert_equal :success, return_code
  end
  
  def test_create_user_returns_error_if_user_exists
    account_name = "newacc"
    @auth.create(account_name, "D3f&lte")
    return_code = @auth.create(account_name, "F00b&re")
    assert_equal :already_exists, return_code
  end
  
end

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

class TestErrs < Test::Unit::TestCase
  def test_can_retrieve_messages
    assert_equal "Account created", Messages.lookup(:success)
  end
end

# class TestPassword < Test::Unit::TestCase
#   def test_validate_password_returns_true_when_all_conventions_met
#     assert Password.valid?("p@sSw0rd")
#   end
#   
#   def test_validate_password_returns_false_when_password_less_than_6_chars
#     assert !Password.valid?("p@sSw0")
#   end
#   
#   def test_validate_password_returns_true_when_password_7_chars
#     assert Password.valid?("p@sSw0r")
#   end
# 
#   def test_validate_password_returns_false_when_password_more_than_20_chars
#     assert !Password.valid?("p@sSw0rd" + "A"*13)
#   end
#   
#   def test_validate_password_returns_false_when_password_missing_special_characters
#     assert !Password.valid?("pasSw0rd")
#   end
#   
#   def test_validate_password_returns_false_when_password_has_invalid_characters
#     assert !Password.valid?("p@sS'w0rd")
#   end
#   
#   def test_valid_returns_false_when_missing_lower_letter
#     assert !Password.valid?("P@SSW0RD")
#   end
#   
#   def test_valid_returns_false_when_missing_upper_letter
#     assert !Password.valid?("p@ssw0rd")
#   end
#   
#   def test_validate_password_returns_false_when_password_missing_number
#     assert !Password.valid?("p@sSword")
#   end
# 
# end



