require 'rubygems'
require 'sinatra'
require 'tmpdir'
require 'erb'
require 'auth.rb'
pwd_file = PasswordFile.new()
auth = Authentication.new(pwd_file)
get '/' do
  erb :login
end
post '/create' do
  return_code = auth.send(:create, params[:uname], params[:pwd]) 
  @message = Messages.lookup(return_code)
  erb :page
end
post '/login' do
  return_code = auth.send(:login, params[:uname], params[:pwd]) 
  @message = Messages.lookup(return_code)
  erb :page
end
