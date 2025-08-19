source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
gem 'jbuilder'
gem 'ostruct'
gem 'pg'
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Terser as compressor for JavaScript assets - Uglifier doesn't play well with ES6
gem 'terser'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :windows]
  # Adds support for Capybara system testing and selenium driver
  gem 'apparition', github: 'twalpole/apparition'
  gem 'capybara'
  gem 'rubocop'
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  # gem 'web-console', '>= 3.3.0'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Bootstrap
gem 'bootstrap', '~>4.0'
gem 'jquery-rails'
gem 'mini_racer'

# Authentication
gem 'devise'
