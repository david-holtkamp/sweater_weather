# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'

SimpleCov.start 'rails' do
  add_filter "/app/channels/application_cable/"
  add_filter "/app/jobs/"
  add_filter "/app/mailers/"
end

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV['GOOGLE_API_KEY'] }
  config.filter_sensitive_data('<OPEN_WEATHER_KEY>') { ENV['OPEN_WEATHER_KEY'] }
  config.filter_sensitive_data('<PEXEL_API_KEY>') { ENV['PEXEL_API_KEY'] }
  config.allow_http_connections_when_no_cassette = true
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
