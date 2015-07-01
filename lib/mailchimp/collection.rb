module Mailchimp
  module Collection
    DEFAULT_PAGE_SIZE = 500

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

    def page
      return @page if @page

      options = {
        'data_key' => self.class.data_key,
        'offset' => offset,
        'count' => page_size
      }

      @page = @client.get(path, options)
    end

    def page_array
      @page_array ||= page[self.class.data_key]
    end

    def page_children
      @page_children ||= page_array.map { |d| self.class.child_class.new @client, d, path }
    end

    def offset
      @offset ||= 0
    end

    def page_size
      @page_size ||= DEFAULT_PAGE_SIZE
    end

    def find_in_pages(options = {})
      parse_options(options)

      loop do
        yield page_children
        @offset += page_size

        if offset > count
          @offset = 0
          break
        end

        invalidate_current_page
      end
    end

    def find_each
      find_in_pages do |p|
        p.each { |child| yield child }
      end
    end

    def parse_options(options = {})
      @offset = options['start'] if options.key? 'start'
      @page_size = options['page_size'] if options.key? 'page_size'
      invalidate_current_page
    end

    def invalidate_current_page
      @page = @page_array = @page_children = nil
    end
  end
end
