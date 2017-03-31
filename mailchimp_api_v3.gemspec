# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailchimp_api_v3/version'

Gem::Specification.new do |spec|
  spec.name = 'mailchimp_api_v3'
  spec.version = Mailchimp::VERSION
  spec.authors = ['Dominic Sayers']
  spec.email = ['dominic@sayers.cc']
  spec.description = 'A simple gem to interact with Mailchimp through their API v3'
  spec.summary = 'Example: mailchimp.lists("My first list").member("ann@example.com")'
  spec.homepage = 'https://github.com/dominicsayers/mailchimp_api_v3'
  spec.license = 'BSD-2-Clause'

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR).reject { |file| file =~ %r{^spec/} }
  spec.executables = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features|coverage)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 2' # https://github.com/rest-client/rest-client/issues/369
end
