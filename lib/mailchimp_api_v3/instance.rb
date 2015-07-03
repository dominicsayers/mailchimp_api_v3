module Mailchimp
  module Instance
    module InstanceMethods
      def initialize(client, data, collection_path = '')
        @client = client
        @collection_path = collection_path
        @data = data
        #- puts @data # debug
      end

      def update(new_data)
        @data = @client.patch(new_data, path)
        self
      end

      def path
        @path ||= "#{@collection_path}/#{@data['id']}"
      end

      def matches?(match_data)
        match_data.each do |k, v|
          break false unless __send__(k).casecmp(v).zero? # case-insensitive comparison
          true
        end
      end

      def subclass_from(collection_class, options = {})
        if options.is_a? String
          # Use it as an id for an instance
          child_path = "#{path}/#{collection_class::PATH_KEY}"
          collection_class::CHILD_CLASS.get @client, child_path, options
        else
          # Get the collection
          collection_class.new @client, path, options
        end
      end

      private

      attr_reader :data

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
    end

    module ClassMethods
      def get(client, collection_path, id)
        data = client.get "#{collection_path}/#{id}"
        new client, data, collection_path
      end
    end
  end
end
