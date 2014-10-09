require 'cucumber/rails'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'byebug'

Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {debug: false, js_errors: false, timeout: 600})
end

Capybara.javascript_driver = :poltergeist

Warden.test_mode! 
World Warden::Test::Helpers
After { Warden.test_reset! }

Capybara.raise_server_errors = false

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation