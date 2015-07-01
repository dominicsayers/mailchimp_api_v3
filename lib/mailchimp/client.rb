require 'yaml'
require 'restclient'
require 'mailchimp/exception'
require 'mailchimp/collection'
require 'mailchimp/instance'
require 'mailchimp/account'
require 'mailchimp/lists'

module Mailchimp
  class Client
    def account
      Account.new self, '', get('')
    end

    def lists
      Lists.new self, ''
    end

    def connected?
      account
    rescue Mailchimp::Exception::APIKeyError
      false
    else
      true
    end

    def get(path, data_key = nil, options = {})
      data = YAML.load(RestClient.get("#{url}#{path}#{to_query(data_key, options)}", auth))
      data_key ? data[data_key] : data
    rescue RestClient::Unauthorized => e
      raise Mailchimp::Exception::APIKeyError, YAML.load(e.http_body)
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

    def to_query(data_key = nil, options = {})
      default = data_key ? { 'exclude_fields' => "#{data_key}._links" } : {}
      params = default.merge(options)
      query = ''
      delim = '?'

      params.each do |k, v|
        query += "#{delim}#{k}=#{v}"
        delim = '&'
      end

      query
    end
  end
end
