raise "Please set environment variables GMAIL_SMTP_USER and GMAIL_SMTP_PASSWORD" \
  unless ENV['GMAIL_SMTP_USER'] && ENV['GMAIL_SMTP_PASSWORD']

MAILER_CONFIG = YAML.load_file(File.expand_path("../config/mailer.yml", File.dirname(__FILE__))).symbolize_keys

Mail.defaults do
  delivery_method :smtp, { 
    :address   => MAILER_CONFIG[:address],
    :port      => MAILER_CONFIG[:port],
    :domain    => MAILER_CONFIG[:domain],
    :user_name => ENV['GMAIL_SMTP_USER'],
    :password  => ENV['GMAIL_SMTP_PASSWORD'],
    :email     => MAILER_CONFIG[:email],
    :enable_starttls_auto => true }
end

# Remember to setup the following configs when deploy using heroku
# $ heroku config:add GMAIL_SMTP_USER=username@gmail.com
# $ heroku config:add GMAIL_SMTP_PASSWORD=yourpassword