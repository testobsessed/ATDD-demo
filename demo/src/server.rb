require 'rubygems'
require 'sinatra'
require 'tmpdir'
require 'erb'
require 'partials'
require 'auth.rb'

include Sinatra::Partials

pwd_file = PasswordFile.new()
auth = Authentication.new(pwd_file)
puts "CREATED FILE AT: #{pwd_file.path}"

get '/' do
  @template = :login
  erb :page
end

post '/create' do
  return_code = auth.send(:create, params[:uname], params[:pwd])
  @message = Messages.lookup(return_code)
  if (@message == "Account created")
    @color = "green"
  else
    @color = "red"
  end
  @template = :response
  erb :page
end

post '/login' do
  return_code = auth.send(:login, params[:uname], params[:pwd]) 
  @message = Messages.lookup(return_code)
  @template = :response
  if (@message == "Welcome!")
    @color = "green"
  else
    @color = "red"
  end
  erb :page
end

get '/reload' do
  auth.send(:load_users)
end

