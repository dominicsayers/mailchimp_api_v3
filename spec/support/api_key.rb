require 'yaml'

unless ENV['MAILCHIMP_API_KEY']
  if File.exist?('api_key.yml')
    ENV['MAILCHIMP_API_KEY'] = YAML.load_file('api_key.yml')['api_key'] # api_key.yml is ignored in .gitignore
  else
    ENV['MAILCHIMP_API_KEY'] = 'vcr_playback-us11' # Will successfully replay the VCR cassettes
  end
end

ENV['MAILCHIMP_DC'] = ENV['MAILCHIMP_API_KEY'].split('-')[1]
