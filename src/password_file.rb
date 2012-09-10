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

