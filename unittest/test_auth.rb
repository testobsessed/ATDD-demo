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