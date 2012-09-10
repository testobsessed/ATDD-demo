require 'rake/testtask'

Rake::TestTask.new(:robot) do |t|
  exec ("cd systest; pybot -P resources --variable interface:cli -s basic_login .")
end

Rake::TestTask.new(:fast) do |t|
  exec ("cd unittest; ruby suite.rb")
end

