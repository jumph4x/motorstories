source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'haml-rails'
gem 'craigslist', :git => 'git://github.com/gregstallings/craigslist.git'
gem 'devise'
gem 'active_hash'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
end

group :test do
  gem 'factory_girl_rails', '~> 3.0'
  gem 'faker'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'spork'
  #gem 'capybara'
end

group :production, :staging do
  gem 'pg'
  gem 'ratchetio', '>= 0.4.0'
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation', '~> 4.0.0'
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
