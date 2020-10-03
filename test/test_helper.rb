require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module ActionDispatch
  class IntegrationTest
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL
    # Make `assert_*` methods behave like Minitest assertions
    include Capybara::Minitest::Assertions

    def disable_javascript
      # Disable Javascript by using the rack driver
      Capybara.current_driver = :rack_test
    end

    # Reset sessions and driver between tests
    # Use super wherever this method is redefined in your individual test classes
    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end

# Capybara config
Capybara.server = :puma, { Silent: true }
Capybara.default_driver = :webkit
Capybara.ignore_hidden_elements = true
Capybara::Webkit.configure(&:block_unknown_urls)
