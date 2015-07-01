module Mailchimp
  module Instance
    def initialize(client, data, collection_path = '')
      @client = client
      @collection_path = collection_path
      @data = data
      #- puts @data # debug
    end

    def path
      @path ||= "#{@collection_path}/#{@data['id']}"
    end

    def method_missing(symbol, options = {})
      key = symbol.id2name
      fail_unless_exists key, options
      @data[key]
    end

    def fail_unless_exists(key, options = {})
      return if @data.key? key
      message = options == {} ? key : "#{key}: #{options}"
      fail Mailchimp::Exception::UnknownAttribute, message
    end

    def fail_unless_id_in(data = {})
      return if data.key? 'id'
      fail Mailchimp::Exception::MissingId, data
    end
  end
end
