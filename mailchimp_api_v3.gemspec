lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailchimp_api_v3/version'

Gem::Specification.new do |spec|
  spec.name = 'mailchimp_api_v3'
  spec.version = Mailchimp::VERSION
  spec.authors = ['Xenapto']
  spec.email = ['developers@xenapto.com']
  spec.description = 'A simple gem to interact with Mailchimp through their API v3'
  spec.summary = 'Example: mailchimp.lists("My first list").member("ann@example.com")'
  spec.homepage = 'https://github.com/Xenapto/mailchimp_api_v3'
  spec.license = 'BSD-2-Clause'

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features|coverage)\/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 1'

  spec.add_development_dependency 'bundler', '~> 1'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency 'coveralls', '~> 0'
  spec.add_development_dependency 'vcr', '~> 3'
  spec.add_development_dependency 'webmock', '~> 2'
  spec.add_development_dependency 'listen', '~> 3.0', '< 3.1' # Dependency of guard, 3.1 requires Ruby 2.2+
  spec.add_development_dependency 'guard', '~> 2'
  spec.add_development_dependency 'guard-rspec', '~> 4'
  spec.add_development_dependency 'guard-rubocop', '~> 1'
  spec.add_development_dependency 'gem-release', '~> 0'
end
