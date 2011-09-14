# -*- coding: utf-8 -*-
$:.unshift File.join(Dir.getwd, 'lib')

require 'sinatra'
require 'core_ext'
require 'mailer'

class Ucheke < Sinatra::Base
  enable :sessions
  set :root, File.dirname(__FILE__)

  def test_mode?
    ENV['RACK_ENV'] == 'test'
  end
    
  def success_mail_message
    if test_mode?
      "Message has been sent successfully"
    else
      "您的邮件已成功发送，感谢您的参与!"
    end
  end
  
  def blank_name_message
    if test_mode?
      "Name cannot be blank"
    else
      "名字不能为空"
    end
  end

  def blank_content_message
    if test_mode?
      "Content cannot be blank"
    else
      "内容不能为空"
    end
  end

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
    if params[:name].blank?
      redirect_with_flash '/', blank_name_message
    elsif params[:content].blank?
      redirect_with_flash '/', blank_content_message
    else
      mail = Mail.new
      mail.to      = MAILER_CONFIG[:email]
      mail.from    = MAILER_CONFIG[:email]
      mail.subject = "#{params[:name]} from #{params[:email]} has just sent this email"
      mail.body    = params[:content]
      mail.deliver
      redirect_with_flash '/', success_mail_message
    end
  end
end
