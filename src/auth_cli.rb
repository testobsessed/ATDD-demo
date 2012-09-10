$LOAD_PATH << File.join(File.dirname(__FILE__), "../src")
require 'auth'

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

# if being called from the cmd line with args
if !(ARGV[0].nil?)
  # setup the authentication server
  pwd_file = PasswordFile.new()
  auth     = Authentication.new(pwd_file)

  # grab the input and write out the output to stdout
  puts CommandLine.CalledWith(auth, ARGV)

end