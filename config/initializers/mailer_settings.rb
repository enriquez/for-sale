require 'smtp_tls'

ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => "smtp.gmail.com",
  :port => "587",
  :authentication => :plain,
  :domain => APP_CONFIG['gmail_domain'],
  :user_name => APP_CONFIG['gmail_username'],
  :password => APP_CONFIG['gmail_password']
}

ActionMailer::Base.default_url_options[:host] = APP_CONFIG["domain"]
