source 'https://rubygems.org'

gem 'rails', '~> 4.1'
gem 'mongo_mapper', github: 'mongomapper/mongomapper'
gem 'bson_ext'
gem "mongo_session_store-rails4"

gem 'haml-rails'
gem "jquery-rails"
#gem 'craigslist', :git => 'git://github.com/gregstallings/craigslist.git'
gem 'browser'

gem 'devise'
gem 'mm-devise', :git => "git://github.com/jpteti/mm-devise"

gem 'carrierwave'
gem 'mm-carrierwave'

gem 'stringex'
gem 'dynamic_form'

gem 'aces_crawler', git: 'git@github.com:jumph4x/aces_crawler.git'
gem 'mina'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'rack-rewrite'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  #gem 'quiet_assets'
  gem 'thin'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 3.0'
  gem 'faker'
  gem 'database_cleaner'
  gem 'spork'
  gem 'capybara'
  gem 'poltergeist'
end

group :production, :staging do
  gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0'
  gem 'coffee-rails'

  gem 'foundation-rails'
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
