source 'https://rubygems.org'

gem 'rails', '~> 3.2.12'
gem 'mongo_mapper'
gem 'bson_ext'

gem 'haml-rails'
gem 'craigslist', :git => 'git://github.com/gregstallings/craigslist.git'
gem 'browser'

gem 'mm-devise'
gem 'devise'

gem 'mm-carrierwave'
gem 'carrierwave'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
end

group :test do
  gem 'factory_girl_rails', '~> 3.0'
  gem 'faker'
  gem 'database_cleaner'
  gem 'spork'
  gem 'capybara'
end

group :production, :staging do
  gem 'ratchetio', '>= 0.4.0'
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation', :git => 'git://github.com/zurb/foundation.git'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
