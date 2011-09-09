MAILER_CONFIG = YAML.load_file(File.expand_path("../config/mailer.yml", File.dirname(__FILE__))).symbolize_keys

Mail.defaults do
  delivery_method :smtp, { 
    :address   => MAILER_CONFIG[:address],
    :port      => MAILER_CONFIG[:port],
    :domain    => MAILER_CONFIG[:domain],
    :user_name => MAILER_CONFIG[:user_name],
    :password  => MAILER_CONFIG[:password],
    :email     => MAILER_CONFIG[:email],
    :enable_starttls_auto => true }
end

# mail = Mail.deliver do
#   to 'yourRecipient@domain.com'
#   from 'Your Name <name@domain.com>'
#   subject 'This is the subject of your email'
#   text_part do
#     body 'Hello world in text'
#   end
#   html_part do
#     content_type 'text/html; charset=UTF-8'
#     body '<b>Hello world in HTML</b>'
#   end
# end