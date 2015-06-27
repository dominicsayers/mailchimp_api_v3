module Mailchimp
  module Base
    def initialize(data)
      @data = data
    end

    def method_missing(symbol)
      @data[symbol.id2name]
    end
  end
end
