require 'rubygems'
require 'sinatra'
require 'tmpdir'
require 'auth.rb'
pwd_file = PasswordFile.new()
auth = Authentication.new(pwd_file)
post '/create' do
  return_code = auth.send(:create, params[:uname], params[:pwd]) 
  return Messages.lookup(return_code)
end
post '/login' do
  return_code = auth.send(:login, params[:uname], params[:pwd]) 
  return Messages.lookup(return_code)
end
