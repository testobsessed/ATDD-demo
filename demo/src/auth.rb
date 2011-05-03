require 'tmpdir'
$LOAD_PATH << File.join(File.dirname(__FILE__), "../src")
require 'messages'

class PasswordFile
  attr :path
  
  def initialize(passwords_file_path="#{Dir.tmpdir}/pwds.txt")
    @path = passwords_file_path
  end
  
  def get_users()
    user_accounts = {}
    if File.exists?(@path)
      password_file = File.open(@path)
      password_file.each_line do |acct|
        data = acct.split("\t")
        user_accounts[data[0].to_s] = {:name => data[0].to_s, :pwd => data[1].to_s, :status => data[2].chomp!.to_sym}
      end
      password_file.close
    end
    return user_accounts
  end
  
  def save(user_accounts)
    password_file = File.open(@path, "w")
    user_accounts.each do |userid, values|
      password_file.puts(userid.to_s + "\t" + values[:pwd].to_s + "\t" + values[:status].to_s)
    end
    password_file.close
    get_users
  end
  
  def delete
    save({})
  end
  
  def user_exists?(username, password, state)
    if File.exists?(@path)
      password_file = File.open(@path)
      raw_accounts = password_file.lines.map {|line| "#{line}"}
      password_file.close
      raw_accounts.each do |acct|
        return acct == "#{username}\t#{password}\t#{state}"
      end
      return false
    else
      false
    end
  end
end

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
    return :success
  end
  
  def login(username, password)
    if !@user_accounts[username].nil? && @user_accounts[username][:pwd] == password
      @user_accounts[username][:status] = :online
      @pwd_file.save(@user_accounts)
      return :logged_in
    else
      return :access_denied
    end
  end
  
  def get_user(name)
    return User.new(name, @user_accounts[name])
  end

end

class User
  attr :name
  attr :pwd
  attr :status
  
  def initialize(name, user_data)
    @name = name
    @pwd = user_data[:pwd]
    @status = user_data[:status]
  end
  
  def logged_in?
    return @status == :online
  end
  
  def password_equals(password)
    return password == @pwd
  end
end

class CommandLine
  
  def self.CalledWith(auth, args)
    return Messages.lookup(:no_cmd) if args.nil?
    
    if auth.respond_to?(args[0].to_sym)
      return_code = auth.send(args[0].to_sym, args[1], args[2])
      return Messages.lookup(return_code)
    else
      return Messages.lookup(:unknown) + " '#{args[0]}'"
    end
  end
end

# class Password
#   Minlen=7
#   Maxlen=20
#   MustInclude = [/[a-z]/, /[A-Z]/, /[0-9]/, /[ !@#&_+=;<>?,.]/]
#   CannotInclude = /[^a-zA-Z0-9 !@#&_+=;<>?,.]/
#   
#   def self.valid?(password)
#     password.length.between?(Minlen, Maxlen) &&
#       includes_required_chars?(password) &&
#       excludes_forbidden_chars?(password)
#   end
#   
#   def self.includes_required_chars?(password)
#     MustInclude.each do |regex|
#       return false if password.match(regex).nil?
#     end
#     true
#   end
#   
#   def self.excludes_forbidden_chars?(password)
#     password.match(CannotInclude).nil?
#   end
# end
