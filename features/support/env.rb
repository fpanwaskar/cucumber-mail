require 'rubygems'
require 'rest-client'
require 'json'

require 'capybara'
require 'capybara/dsl'

Capybara.default_driver = :selenium
Capybara.app_host = "http://10.63.36.213:8080"

World(Capybara)