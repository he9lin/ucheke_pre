$:.unshift File.join(Dir.getwd, 'lib')

require 'sinatra'
require 'mailer'

get '/'  do
  erb :home
end