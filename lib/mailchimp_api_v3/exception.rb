module MailchimpAPIV3
  module Exception
    def self.parse_invalid_resource_exception(data)
      detail = data['detail']

      if detail.include? 'already exists'
        fail Duplicate, data
      elsif detail.include? 'can\'t be blank'
        fail MissingField, data
      else
        fail BadRequest, data
      end
    end

    class DataException < RuntimeError
      def initialize(data)
        @data = data
        super name || title
      end

      def method_missing(symbol)
        @data[symbol.id2name]
      end
    end

    class APIKeyError < DataException
    end

    class Duplicate < DataException
    end

    class MissingField < DataException
    end

    class BadRequest < DataException
    end

    class UnknownAttribute < RuntimeError
    end

    class MissingId < RuntimeError
    end
  end
end
