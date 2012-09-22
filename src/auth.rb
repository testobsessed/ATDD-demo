require 'tmpdir'
$LOAD_PATH << File.join(File.dirname(__FILE__), "../src")
require 'messages'
require 'password'
require 'password_file'
require 'user'

class Authentication
  attr :user_accounts
  attr :password_file
  attr :filepath
  attr :pwd_file
  
  def initialize(pwd_file)
    @pwd_file = pwd_file
    load_users
    return nil
  end
  
  def load_users()
    @user_accounts = @pwd_file.get_users
    return nil
  end
  
  def account_exists?(username)
    !@user_accounts[username].nil?
  end
  
  def create(username, password, status=:active)
    return :already_exists if account_exists?(username)
    account_data = {}
    account_data[:pwd] = password
    account_data[:status] = status
    @user_accounts[username] = account_data
    @pwd_file.save(@user_accounts)
    puts "#{Time.now}: created account with username #{username} in password file at #{@pwd_file.path}"
    return :success
  end
  
  def login(username, password)
    if !@user_accounts[username].nil? && @user_accounts[username][:pwd] == password
      @user_accounts[username][:status] = :online
      @pwd_file.save(@user_accounts)
      puts "#{Time.now}: successful login as #{username}"
      return :logged_in
    else
      puts "#{Time.now}: failed attempt to login as #{username}"
      return :access_denied
    end
  end
  
  def get_user(name)
    return User.new(name, @user_accounts[name])
  end

end