require 'capypage'
require 'yaml'

class TestPage <  Capypage::Page;
  config = YAML.load_file('cucumber.yml')
  if ENV['environment']=='current'
    set_url config['current_test_vrt_url']
  elsif ENV['environment']=='reference'
    sleep(2)
    set_url config['reference_test_vrt_url']
  end


  element :text_box, '#leftMillis'


end