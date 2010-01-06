require 'yaml'
class Messages
  @@mappings = YAML::load(File.read(File.dirname(__FILE__) + "/msgs.yml"))
  
  
  def self.lookup(msg_symbol)
    return @@mappings[msg_symbol]
  end
end