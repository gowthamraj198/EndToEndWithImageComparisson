require 'capybara/node/matchers'
require 'capybara/dsl'
require 'capybara/node/matchers'
require 'yaml'


Before('@current_time') do
  test_page.load
end


at_exit do
  ReportBuilder.configure do |config|
    config.json_path = 'output/json_reports'
    config.report_path = 'output/my_test_report'
    config.report_types = [:html]
    config.report_tabs = [:overview, :features, :scenarios, :errors]
    config.report_title = 'Test Results'
    config.additional_info = {browser: 'poltergeist', environment: 'Integration'}
  end
  ReportBuilder.build_report
end
