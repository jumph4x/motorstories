ENV["RAILS_ENV"] ||= 'test'
# This file is copied to spec/ when you run 'rails generate rspec:install'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner[:mongo_mapper].strategy = :truncation
    DatabaseCleaner[:mongo_mapper].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:mongo_mapper].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongo_mapper].clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, :type => :controller

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
