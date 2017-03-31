# frozen_string_literal: true

module Mailchimp
  module Exception
    def self.parse_invalid_resource_exception(data)
      detail = data['detail']

      raise Duplicate, data if detail.include? 'already'
      raise MissingField, data if detail.include? 'can\'t be blank'
      raise BadRequest, data
    end

    class DataException < RuntimeError
      def initialize(data)
        @data = data.is_a?(String) ? { 'detail' => data } : data
        super detail
      end

      def method_missing(symbol)
        symbol.is_a?(Symbol) ? @data[symbol.id2name] : super
      end

      def respond_to_missing?(symbol, *_)
        symbol.is_a?(Symbol)
      end
    end

    APIKeyError = Class.new(DataException)
    NotFound = Class.new(DataException)
    Duplicate = Class.new(DataException)
    MissingField = Class.new(DataException)
    BadRequest = Class.new(DataException)

    UnknownAttribute = Class.new(RuntimeError)
    MissingId = Class.new(RuntimeError)

    MAPPED_EXCEPTIONS = {
      'RestClient::NotFound' => NotFound,
      'RestClient::Unauthorized' => APIKeyError
    }.freeze

    BAD_REQUEST = 'RestClient::BadRequest'.freeze
  end
end
