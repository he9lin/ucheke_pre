require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require(:default, :test)

require 'capybara'
require 'capybara/dsl'
require 'test/unit'

ENV['RACK_ENV'] ||= 'test'

$:.unshift File.expand_path("..", File.dirname(__FILE__))
require 'ucheke'

# Setup mail test
Mail.defaults do
  delivery_method :test
end

set :views => File.join(File.dirname(__FILE__), '..', 'views')
