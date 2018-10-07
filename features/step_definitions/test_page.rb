require_relative '../support/pages/test_page'
require 'capybara'
require 'capybara/dsl'
require 'capybara/session'
require 'selenium/webdriver/common/action_builder'
require 'imatcher'

Then("User is in test page") do
  test_page.text_box.visible?
end

When("User enters milliseconds {string}") do |text|
  test_page.text_box.set text
end
