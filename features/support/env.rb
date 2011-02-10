require 'rubygems'
require 'rest-client'
require 'json'

require 'capybara'
require 'capybara/dsl'
require 'test/unit/assertions'

Capybara.default_driver = :selenium
Capybara.app_host = "http://10.63.36.213:8080"
Capybara.default_wait_time = 10

Capybara.register_driver :selenium do |app|
  Capybara::Driver::Selenium.new(app, :browser => :chrome)
end

World(Capybara)
World(Test::Unit::Assertions)
