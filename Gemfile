source 'http://rubygems.org'

gem 'rails', '3.1.0'

group :test, :development do
  gem 'rspec-rails'
  gem 'webrat'
end

if defined?(JRUBY_VERSION)
  gem 'therubyrhino'
  gem 'jdbc-sqlite3'
  gem 'activerecord-jdbc-adapter'
  gem 'jruby-openssl'
else
  gem 'therubyracer'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

gem 'json'
gem "oauth-plugin", ">= 0.4.0.rc2"
gem 'will_paginate', '~> 3.0.beta'
gem "recaptcha"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

