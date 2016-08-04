# frozen_string_literal: true
unless ENV['NO_SIMPLECOV']
  require 'simplecov'
  require 'coveralls'

  if ENV['CIRCLE_ARTIFACTS']
    dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start { add_filter '/spec/' }
  Coveralls.wear! if ENV['COVERALLS_REPO_TOKEN']
end

require 'mailchimp_api_v3'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'
  config.tty = true
end
