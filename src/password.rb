class Password
  @@Minlen=7
  @@Maxlen=20
  @@MustInclude = [/[a-z]/, /[A-Z]/, /[0-9]/, /[ !@#&_+=;<>?,.]/]
  @@CannotInclude = /[^a-zA-Z0-9 !@#&_+=;<>?,.]/
  
  def self.valid?(password)
    password.length.between?(@@Minlen, @@Maxlen) &&
      includes_required_chars?(password) &&
      excludes_forbidden_chars?(password)
  end
  
  def self.includes_required_chars?(password)
    @@MustInclude.each do |regex|
      return false if password.match(regex).nil?
    end
    true
  end
  
  def self.excludes_forbidden_chars?(password)
    password.match(@@CannotInclude).nil?
  end
end
