module Mailchimp
  class APIKeyError < StandardError
    def initialize(data)
      @data = data
      super title
    end

    def method_missing(symbol)
      @data[symbol.id2name]
    end
  end
end
