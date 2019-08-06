source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.rc2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

gem 'coffee-rails', '~> 5.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.5'
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'turbolinks', '~> 5.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'jquery-atwho-rails', '~> 1.5', '>= 1.5.4'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
gem 'twemoji', '~> 3.1', '>= 3.1.5'
gem 'dropzonejs-rails', '~> 0.8.4'
gem 'rails-i18n', '~> 5.1', '>= 5.1.3'

# Faster inserts! Insert N records in a single statement.
gem "bulk_insert"

# User system
gem 'devise', '~> 4.6', '>= 4.6.2'

# page
gem 'kaminari', '~> 1.1', '>= 1.1.1'

# soft delete
gem 'paranoia', '~> 2.4', '>= 2.4.2'

gem 'mini_magick', '~> 4.9', '>= 4.9.5', require: false

# upload pluge
gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'letter_avatar', '~> 0.3.7'

gem 'carrierwave-qiniu', '~> 1.1', '>= 1.1.6'

# Form select 选项
gem 'form-select', '~> 0.3.2'

# Redis
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.1', '>= 4.1.2'
gem 'redis-namespace', '~> 1.6'
gem 'redis-objects', '~> 1.4', '>= 1.4.3'

# Cache
gem 'second_level_cache', '~> 2.4', '>= 2.4.4'

# 队列
gem 'sidekiq', '~> 5.2', '>= 5.2.7'
gem 'sidekiq-scheduler', '~> 3.0'

# Setting
gem 'rails-settings-cached', '~> 2.1'

# HTML Pipeline
gem "auto-space"
gem "html-pipeline"
gem "html-pipeline-rouge_filter"
gem "redcarpet"
gem 'sanitize', '~> 5.0'

# 搜索
gem "elasticsearch-model", "~> 5.0.2"
gem "elasticsearch-rails", "~> 5.0.2"

# Share
gem 'social-share-button', '~> 1.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
