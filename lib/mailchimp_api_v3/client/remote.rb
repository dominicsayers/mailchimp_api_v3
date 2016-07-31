require 'yaml'
require 'restclient'

module Mailchimp
  class Client < Instance
    module Remote
      def get(path = '', options = {})
        managed_remote path, :get, options
      end

      def post(path, data, options = {})
        managed_remote path, :post, options, data
      end

      def patch(path, data, options = {})
        managed_remote path, :patch, options, data
      end

      def delete(path)
        managed_remote path, :delete
      end

      private

      RETRY_EXCEPTIONS = [SocketError].freeze

      def managed_remote(path, method = :get, options = {}, payload = nil)
        headers_and_params = headers.merge params_from(options)
        YAML.load naked_remote("#{url_stub}#{path}", method, headers_and_params, payload)
      rescue *RETRY_EXCEPTIONS => e
        @retries ||= 0
        raise e if (@retries += 1) > 3
        retry
      rescue => e # TODO: Find out why this doesn't fire if we rescue RestClient::Exception
        managed_remote_exception e
      end

      def managed_remote_exception(e)
        data = YAML.load(e.http_body) if e.respond_to? :http_body
        exception_class_name = e.class.to_s

        if Mailchimp::Exception::MAPPED_EXCEPTIONS.key? exception_class_name
          raise Mailchimp::Exception::MAPPED_EXCEPTIONS[exception_class_name], data
        elsif exception_class_name == 'RestClient::BadRequest'
          Mailchimp::Exception.parse_invalid_resource_exception data
        else
          raise e
        end
      end

      def naked_remote(url, method, headers_and_params, payload = nil)
        if [:get, :delete, :head, :options].include? method
          remote_no_payload(url, method, headers_and_params)
        else
          remote_with_payload(url, payload, method, headers_and_params)
        end
      end

      def remote_no_payload(url, method, headers_and_params = {})
        RestClient.__send__ method, url, headers_and_params
      end

      def remote_with_payload(url, payload, method, headers_and_params = {})
        RestClient.__send__ method, url, payload.to_json, headers_and_params
      end

      def headers
        @headers ||= {
          'Authorization' => "apikey #{@api_key}",
          'User-Agent' => 'Mailchimp API v3 Ruby gem https://rubygems.org/gems/mailchimp_api_v3'
        }.merge @extra_headers
      end

      def url_stub
        @url_stub ||= "https://#{dc}.api.mailchimp.com"
      end

      def params_from(options = {})
        options == {} ? {} : { 'params' => options }
      end
    end
  end
end
