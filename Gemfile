# frozen_string_literal: true

source 'https://rubygems.org'
gemspec
ruby RUBY_VERSION

group :development do
  gem 'bundler'
  gem 'gem-release'
  gem 'github_changelog_generator'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
end

group :test do
  gem 'codeclimate-test-reporter'
  gem 'coveralls'
  gem 'fuubar'
  gem 'rake' # Workaround for a bug in Rainbow 2.2.1 https://github.com/sickill/rainbow/issues/44
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
