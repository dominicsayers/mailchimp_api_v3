require 'mailchimp/collection/paging'

module Mailchimp
  module Collection
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
      @path ||= "#{@parent_path}/#{self.class.path_key}"
    end

    def find(data)
      find_each do |instance|
        matches = data.each do |k, v|
          break false unless instance.__send__(k).casecmp(v).zero? # case-insensitive comparison
          true
        end

        break instance if matches
      end
    end

    def create(data)
      response = @client.post data, path
      self.class.child_class.new @client, response, path
    end

    def first_or_create(data)
      instance = find(data)
      return instance if instance
      create(data)
    end
  end
end
