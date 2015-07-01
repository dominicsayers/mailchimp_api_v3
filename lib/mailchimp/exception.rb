module Mailchimp
  module Exception
    class APIKeyError < RuntimeError
      def initialize(data)
        @data = data
        super title
      end

      def method_missing(symbol)
        @data[symbol.id2name]
      end
    end

    class UnknownAttribute < RuntimeError
    end

    class MissingId < RuntimeError
    end
  end
end
