$:.unshift File.join(Dir.getwd, 'lib')

require 'sinatra'
require 'core_ext'
require 'mailer'

class Ucheke < Sinatra::Base
  enable :sessions

  helpers do
    def redirect_with_flash(url, message)
      session[:flash] = message
      redirect url
    end
  
    def flash_message
      message = session[:flash]
      session[:flash] = nil
      message
    end
  end
  
  get '/'  do
    erb :home, :locals => { :flash_message => flash_message }
  end

  post '/mail' do
    mail = Mail.new
    mail.to      = MAILER_CONFIG[:email]
    mail.from    = MAILER_CONFIG[:email]
    mail.subject = "#{params[:name]} from #{params[:email]} has just sent this email"
    mail.body    = params[:content]
    mail.deliver
    redirect_with_flash '/', 'Message has been sent successfully'
  end
end