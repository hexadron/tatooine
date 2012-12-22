require 'simplecov'
SimpleCov.start 'rails'

require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include Capybara::DSL
    config.include TestHelper
    
    config.use_transactional_fixtures = true

    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  # FactoryGirl.reload
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end
end