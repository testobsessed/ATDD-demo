require 'rubygems'
require 'sinatra'
require 'tmpdir'
require 'erb'
require 'partials'
require 'auth.rb'

include Sinatra::Partials

pwd_file = PasswordFile.new()
auth = Authentication.new(pwd_file)

get '/' do
  @template = :login
  erb :page
end

post '/create' do
  return_code = auth.send(:create, params[:uname], params[:pwd]) 
  @message = Messages.lookup(return_code)
  @template = :response
  erb :page
end

post '/login' do
  return_code = auth.send(:login, params[:uname], params[:pwd]) 
  @message = Messages.lookup(return_code)
  @template = :response
  erb :page
end

