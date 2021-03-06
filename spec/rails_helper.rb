ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.example_status_persistence_file_path = "#{::Rails.root}/spec/example"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseRewinder.strategy = :truncation
  end

  config.before(:each) do
    DatabaseRewinder.clean_all
    load "#{Rails.root}/db/seeds.rb"
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.include FeatureHelper, type: :feature
end

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true)
end
