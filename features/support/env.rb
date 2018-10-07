require 'capybara-screenshot/cucumber'
require 'capybara/poltergeist'
require_relative 'page_helper'
require 'report_builder'

World(PageHelper)

Capybara.save_and_open_page_path = File.dirname(__FILE__) + '/../../' + ENV['output'] + '/screenshots/'

if ENV['chrome']
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   desired_capabilities: {
                                       "chromeOptions" => {
                                           "args" => %w{ window-size=1500,1000 }
                                       }
                                   })
  end

  Capybara.javascript_driver = :chrome
  Capybara.ignore_hidden_elements = false
  Capybara.configure do |config|
    config.default_wait_time = 30 # seconds
    config.default_driver        = :chrome
  end

  Capybara::Screenshot.register_driver(:chrome) do |driver, path|
    driver.browser.save_screenshot(path)
  end
elsif ENV['firefox']
  Capybara.configure do |config|
    config.default_wait_time     = 30
  end
  Capybara.default_driver = :firefox
  Capybara.ignore_hidden_elements = false
  Capybara.register_driver :firefox do |app|
    options = {
        :js_errors => false,
        :timeout => 30,
        :debug => false,
        :inspector => true,
    }
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
elsif  ENV['poltergeist']
    Capybara.configure do |config|
      config.default_wait_time     = 20
    end
    Capybara.current_driver = :poltergeist
    Capybara.javascript_driver = :poltergeist
    Capybara.ignore_hidden_elements = false

    if ENV['drupal']
        Capybara.register_driver :poltergeist do |app|
          options = {
              js_errors: false,
              timeout: 30,
              debug: false,
              :inspector => true,
              phantomjs_options: [
                  # '--load-images=yes',
                  # '--ignore-ssl-errors=no',
                  '--ssl-protocol=any']
          }
          Capybara::Poltergeist::Driver.new(app, options)
        end
    elsif ENV['website']
      Capybara.register_driver :poltergeist do |app|
        options = {
            js_errors: false,
            timeout: 40,
            debug: false,
            :inspector => true,
            phantomjs_options: [
                # '--load-images=yes',
                # '--ignore-ssl-errors=no',
                '--ssl-protocol=any']
        }
        Capybara::Poltergeist::Driver.new(app, options)
      end
    end
end
