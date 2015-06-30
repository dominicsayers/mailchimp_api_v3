module Mailchimp
  module Base
    def initialize(client, collection_path, data)
      @client = client
      @collection_path = collection_path
      @data = data
    end

    def path
      @path ||= "#{@collection_path}/#{@data['id']}"
    end

    def collection(klass)
      @client.collection klass, path
    end

    def method_missing(symbol)
      key = symbol.id2name
      fail Mailchimp::UnknownAttribute(key) unless @data.key? key
      @data[key]
    end
  end
end
