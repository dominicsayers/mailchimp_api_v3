module Mailchimp
  module Instance
    module InstanceMethods
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

      def matches?(data)
        data.each do |k, v|
          break false unless __send__(k).casecmp(v).zero? # case-insensitive comparison
          true
        end
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

      def subclass_from(collection_class, options = {})
        if options.is_a? String
          # Use it as an id for an instance
          child_path = "#{path}/#{collection_class.path_key}"
          collection_class.child_class.get @client, child_path, options
        else
          # Get the collection
          collection_class.new @client, path, options
        end
      end
    end

    module ClassMethods
      def get(client, collection_path, id)
        data = client.get "#{collection_path}/#{id}"
        new client, data, collection_path
      end
    end
  end
end
