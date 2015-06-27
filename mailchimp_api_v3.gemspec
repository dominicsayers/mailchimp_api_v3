lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailchimp/version'

Gem::Specification.new do |spec|
  spec.name          = 'mailchimp_api_v3'
  spec.version       = Mailchimp::VERSION
  spec.authors       = ['Xenapto']
  spec.email         = ['developers@xenapto.com']
  spec.description   = 'A simple gem to interact with Mailchimp through their API v3'
  spec.summary       = 'Example: Mailchimp.new(mc_key).lists'
  spec.homepage      = 'https://github.com/Xenapto/mailchimp_api_v3'
  spec.license       = 'BSD'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features|coverage)\/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '> 1.6'

  spec.add_development_dependency 'bundler', '> 1.8'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'gem-release', '~> 0.7'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'guard', '~> 2.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'rubocop', '~> 0.32'
end
