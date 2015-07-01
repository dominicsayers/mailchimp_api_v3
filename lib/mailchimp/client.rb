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

    def get(path = '', options = {})
      puts "#{url}#{path}#{to_query(options)}" # debug
      YAML.load remote(:get, "#{url}#{path}#{to_query(options)}")
    rescue RestClient::Unauthorized => e
      raise Mailchimp::Exception::APIKeyError, YAML.load(e.http_body)
    rescue *RETRY_EXCEPTIONS => e
      @retries ||= 0
      raise e if (@retries += 1) > 3
      retry
    end

    def remote(method = :get, path = '')
      RestClient.__send__ method, path, auth
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

    def to_query(options = {})
      query = ''
      delim = '?'

      query_defaults_from(options).each do |k, v|
        query += "#{delim}#{k}=#{v}"
        delim = '&'
      end

      query
    end

    def query_defaults_from(options = {})
      data_key = options.delete 'data_key'
      linksloc = data_key ? "#{data_key}." : ''
      { 'exclude_fields' => "#{linksloc}_links" }.merge(options)
    end

    RETRY_EXCEPTIONS = [SocketError]
  end
end
