require 'yaml'

ENV['MAILCHIMP_API_KEY'] ||= YAML.load_file('api_key.yml')['api_key'] if File.exist?('api_key.yml')

def api_key?
  ENV.key? 'MAILCHIMP_API_KEY'
end
