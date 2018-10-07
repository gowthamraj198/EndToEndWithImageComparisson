[![EndToEndWithImageComparison]]

# End To End Test Framework With Image Comparison

Run End to end tests on current and reference pages, capture screenshots and compare them for any differences 
This is an utility library for image regression testing.

## Usage

Install gem rails
 ```ruby
 gem install rails
 ```  

Install gem rake
 ```ruby
 gem install rake
 ```  
 
Create a new rails project 
 ```ruby
 rails new project_name
 ``` 

Add imatcher to your application's Gemfile:
```ruby
gem 'imatcher'
```


Create features folder to write BDD tests using cucumber

Define rake tasks to run your tests parallely in both test and reference environments and take screenshots wherever necessary

Once the tests get completed, compare the screenshots one by one and make sure the tests are visually passed!


### Base (RGB) mode

Compare pixels by values, resulting score is a ratio of unequal pixels.
Resulting diff represents per-channel difference.




## Usage

```ruby
# create new matcher with default threshold equals to 0
# and base (RGB) mode
cmp = Imatcher::Matcher.new
cmp.mode #=> Imatcher::Modes::RGB

# create matcher with specific threshold
cmp = Imatcher::Matcher.new threshold: 0.05
cmp.threshold #=> 0.05

# create zero-tolerance grayscale matcher 
cmp = Imatcher::Matcher.new mode: :grayscale, tolerance: 0
cmp.mode #=> Imatcher::Modes::Grayscale

res = cmp.compare(path_1, path_2)
res #=> Imatcher::Result

res.match? #=> true

res.score #=> 0.0

# Return diff image object
res.difference_image #=> Imatcher::Image

res.difference_image.save(new_path)

# without explicit matcher
res = Imatcher.compare(path_1, path_2, options) 

# equals to
res = Imatcher::Matcher.new(options).compare(path_1, path_2)

```

##Execution

```ruby
bundle install
bundle exec rake task_name
```

##Example
[![Refer sample screenshot]]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/teachbase/imatcher.
