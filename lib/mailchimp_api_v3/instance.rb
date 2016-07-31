module Mailchimp
  class Instance
    # Class methods

    def self.get(client, collection_path, id)
      data = client.get "#{collection_path}/#{id}"
      data ? new(client, data, collection_path) : nil
    rescue Mailchimp::Exception::NotFound
      nil
    end

    # Instance methods

    def initialize(client, data, collection_path = '')
      @client = client
      @data = data
      @collection_path = collection_path
      #- puts @data # debug
    end

    def update(new_data)
      @data = @client.patch(path, new_data)
      self
    end

    def delete
      @client.delete(path)
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

    def subclass_from(collection_class, *args)
      id, name, options = parse_args(*args)
      return subclass_instance_from(collection_class, id) if id

      paging_options = options.divide_on('start', 'page_size') if options
      collection = collection_class.new @client, path, paging_options

      return collection.find_by collection.name_field => name if name
      options.nil? || options.empty? ? collection : collection.where(options)
    end

    private

    attr_reader :data

    def method_missing(symbol, options = {})
      key = symbol.id2name
      return @data[key] if @data.key? key
      super
    end

    def respond_to_missing?(symbol)
      key = symbol.id2name
      @data.key? key
    end

    def subclass_instance_from(collection_class, id)
      child_path = "#{path}/#{collection_class::PATH_KEY}"
      collection_class::CHILD_CLASS.get @client, child_path, id
    end

    def parse_args(*args)
      first_arg = args.shift
      second_arg = args.shift

      if first_arg.is_a? String
        id_and_name_from(first_arg) << second_arg
      else
        [nil, nil, first_arg]
      end
    end

    # If string is a hex string assume it's an id, otherwise it's a name
    def id_and_name_from(string)
      string =~ /[^0-9a-f]/i ? [nil, string] : [string, nil]
    end
  end
end
