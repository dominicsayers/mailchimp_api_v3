module Mailchimp
  class Collection < Array
    include Paging

    def initialize(client, parent_path = '', options = {})
      @client = client
      @parent_path = parent_path

      parse_options(options)
      super page_children
    end

    def count
      page['total_items']
    end

    def path
      @path ||= "#{@parent_path}/#{self.class::PATH_KEY}"
    end

    def where(data, limit = nil)
      instances = []

      find_each do |instance|
        if instance.matches? data
          instances << instance
          break if instances.count == limit
        end
      end

      instances
    end

    def find_by(data)
      instances = where(data, 1)
      instances ? instances.first : nil
    end

    def create(data)
      response = @client.post path, data
      self.class::CHILD_CLASS.new @client, response, path
    end

    def first_or_create(data)
      instance = find_by(data)
      return instance if instance
      create(data)
    end

    def create_or_update(data)
      clean_data = data.deep_stringify_keys

      if clean_data.key? 'id'
        instance = self.class::CHILD_CLASS.get @client, path, clean_data.delete('id')
        instance ? instance.update(clean_data) : create(clean_data)
      else
        find_by(clean_data) || create(clean_data)
      end
    end

    def name_field
      self.class.const_defined?(:NAME_FIELD) ? self.class::NAME_FIELD : 'name'
    end
  end
end
