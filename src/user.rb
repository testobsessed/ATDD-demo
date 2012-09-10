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