require 'mailchimp_api_v3/collection'
require 'mailchimp_api_v3/instance'
require 'mailchimp_api_v3/exception'
require 'mailchimp_api_v3/account'
require 'mailchimp_api_v3/list'
require 'mailchimp_api_v3/client/remote'

module Mailchimp
  class Client
    include Remote

    def account
      Account.new self, get
    end

    def lists
      Lists.new self
    end

    def connected?
      account
    rescue Mailchimp::Exception::APIKeyError
      false
    else
      true
    end

    private

    def initialize(api_key = nil, extra_headers = {})
      @api_key = api_key || ENV['MAILCHIMP_API_KEY']

      fail(
        Mailchimp::Exception::APIKeyError,
        'title' => "Invalid API key format: #{@api_key}"
      ) unless api_key_valid?

      @extra_headers = extra_headers
    end

    def api_key_valid?
      @api_key =~ /\w+-\w{3}/
    end

    def dc
      @dc ||= @api_key.split('-')[1]
    end
  end
end
