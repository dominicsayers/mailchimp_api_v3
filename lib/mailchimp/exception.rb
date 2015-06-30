module Mailchimp
  module Exception
    class APIKeyError < StandardError
      def initialize(data)
        @data = data
        super title
      end

      def method_missing(symbol)
        @data[symbol.id2name]
      end
    end

    class UnknownAttribute < StandardError
    end

    class MissingId < StandardError
    end
  end
end
