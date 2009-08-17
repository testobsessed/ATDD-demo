require 'rubygems'
require 'sinatra'
require 'haml'
require 'auth.rb'
pwd_file = PasswordFile.new("./pwds.txt")
auth = Authentication.new(pwd_file)
post '/hi' do
  "Hello World!"
end
get '/' do
  haml :'index'
end
post '/create' do
  return_code = auth.send(:create, params[:uname], params[:pwd]) 
  return Messages.lookup(return_code)
end
post '/login' do
  return_code = auth.send(:login, params[:uname], params[:pwd]) 
  return Messages.lookup(return_code)
end
