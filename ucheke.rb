$:.unshift File.join(Dir.getwd, 'lib')

require 'sinatra'
require 'core_ext'
require 'mailer'

get '/'  do
  erb :home
end

post '/mail' do
  mail = Mail.new
  mail.to      = MAILER_CONFIG[:email]
  mail.from    = "#{params[:name]} <#{params[:email]}>"
  mail.subject = "New inquiry"
  mail.body    = params[:content]
  mail.deliver
  # text_part do
  #   body 'Hello world in text'
  # end
  # html_part do
  #   content_type 'text/html; charset=UTF-8'
  #   body '<b>Hello world in HTML</b>'
  # end
end