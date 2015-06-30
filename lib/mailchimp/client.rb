require 'yaml'
require 'restclient'
require 'mailchimp/exception'
require 'mailchimp/base'
require 'mailchimp/account'
require 'mailchimp/list'

module Mailchimp
  class Client
    KEY = ''

    def account
      instance Account, KEY, get(KEY)
    end

    def lists
      collection List, KEY
    end

    def connected?
      account
    rescue Mailchimp::APIKeyError
      false
    else
      true
    end

    def collection(klass, path)
      child_path = "#{path}/#{klass::KEY}"
      get(child_path)[klass::KEY].map { |i| instance klass, child_path, i }
    end

    private

    def initialize(api_key = nil)
      @api_key = api_key || ENV['MAILCHIMP_API_KEY']
      fail Mailchimp::APIKeyError, 'title' => 'Invalid API key format' unless api_key_valid?
    end

    def api_key_valid?
      @api_key =~ /\w+-\w{3}/
    end

    def dc
      @dc ||= @api_key.split('-')[1]
    end

    def auth
      @auth ||= { Authorization: "apikey #{@api_key}" }
    end

    def url
      @url ||= "https://#{dc}.api.mailchimp.com/3.0"
    end

    def get(path)
      YAML.load RestClient.get("#{url}#{path}", auth)
    rescue RestClient::Unauthorized => e
      raise Mailchimp::APIKeyError, YAML.load(e.http_body)
    end

    def instance(klass, path, data)
      klass.new self, path, data
    end
  end
end
