ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login(user)
    session[:current_user] = user.id
  end

  def admin_user(current_user)
    if current_user && current_user.role_id==1
      true
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Email::DSL
  
  self.use_transactional_fixtures = false
  
  setup do
    Capybara.default_driver = :selenium
    #Capybara.javascript_driver = :selenium
  end
  
  
  teardown do
    DatabaseCleaner.clean
    Capybara.use_default_driver
  end
end
