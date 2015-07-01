module Mailchimp
  module Exception
    def self.parse_invalid_resource_exception(data)
      if data['detail'].include? 'already exists'
        fail Duplicate, data
      else
        fail BadRequest, data
      end
    end

    module DataException
      def initialize(data)
        @data = data
        super name || title
      end

      def method_missing(symbol)
        @data[symbol.id2name]
      end
    end

    class APIKeyError < RuntimeError
      include DataException
    end

    class Duplicate < RuntimeError
      include DataException
    end

    class BadRequest < RuntimeError
      include DataException
    end

    class UnknownAttribute < RuntimeError
    end

    class MissingId < RuntimeError
    end
  end
end
