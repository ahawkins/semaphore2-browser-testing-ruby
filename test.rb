require 'bundler/setup'

class App
  def call(env)
    [ 200, { 'Content-Type' => 'text/html' }, [ '<h1>Hello World</h1>' ] ]
  end
end

require 'minitest/autorun'
require 'capybara/dsl'

Capybara.app = App.new
Capybara.default_driver = ENV.fetch('CAPYBARA_DRIVER', 'rack_test').to_sym

class AppTest < MiniTest::Test
  include Capybara::DSL

  def test_landing_page
    visit '/'

    assert page.has_content?('Hello World')
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
