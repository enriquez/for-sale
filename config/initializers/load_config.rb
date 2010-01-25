# App can be configured by setting values in config/app_config.yml or in your system's environment 
# variables.  Environment variables take precedence over app_config.yml if they're both set.

require 'yaml'

app_config = Hash.new
YAML::load_file(File.expand_path(File.dirname(__FILE__) + "/../app_config.yml"))[RAILS_ENV].each_pair do |key, value|
  app_config[key] = ENV[key] || value
end

APP_CONFIG = app_config
