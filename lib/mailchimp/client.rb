require 'yaml'
require 'restclient'
require 'mailchimp/exception'
require 'mailchimp/base'
require 'mailchimp/account'
require 'mailchimp/list'

module Mailchimp
  class Client
    PATH_KEY = DATA_KEY = ''

    def account
      instance Account, PATH_KEY, get(PATH_KEY)
    end

    def lists
      collection List, PATH_KEY
    end

    def connected?
      account
    rescue Mailchimp::Exception::APIKeyError
      false
    else
      true
    end

    def collection(klass, path)
      child_path = "#{path}/#{klass::PATH_KEY}"
      get(child_path)[klass::DATA_KEY].map { |i| instance klass, child_path, i }
    end

    private

    def initialize(api_key = nil)
      @api_key = api_key || ENV['MAILCHIMP_API_KEY']
      fail Mailchimp::Exception::APIKeyError, 'title' => 'Invalid API key format' unless api_key_valid?
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
      puts "#{url}#{path}" # debug
      YAML.load RestClient.get("#{url}#{path}", auth)
    rescue RestClient::Unauthorized => e
      raise Mailchimp::Exception::APIKeyError, YAML.load(e.http_body)
    end

    def instance(klass, path, data)
      klass.new self, path, data
    end
  end
end
