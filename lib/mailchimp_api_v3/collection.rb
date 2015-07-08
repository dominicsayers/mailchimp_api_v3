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
  end
end
