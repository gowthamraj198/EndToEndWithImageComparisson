require 'capybara'
require 'capybara/dsl'
require 'capybara/session'
require 'selenium/webdriver/common/action_builder'
require 'selenium/webdriver'


def click_an_element(element)
  element.visible?
  element.click()
end

def verify_an_element(element)
  element.visible?
  element.present?
end

Then("User takes the screenshot {string} {string} {string}") do |filename,width,height|
  sleep(3)
  if ENV['environment']=='current'
    take_screenshot(width,height,'result/current/'+filename)
  elsif ENV['environment']=='reference'
    take_screenshot(width,height,'result/reference/'+filename)
  end
end

def element_visible_present(element)
  assert element.visible?
  assert element.present?
end

def take_screenshot(width,height,filename)
Capybara.current_session.driver.resize_window(width, height)
Capybara.current_session.driver.render filename+'.png'
end
