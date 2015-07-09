module Mailchimp
  class Collection < Array
    module Paging
      DEFAULT_PAGE_SIZE = 500

      def page
        return @page if @page
        @page = @client.get(path, fetch_options)
      end

      def fetch_options
        links_delim = self.class::DATA_KEY.empty? ? '' : '._links,'

        {
          'exclude_fields' => "#{self.class::DATA_KEY}#{links_delim}_links",
          'offset' => offset,
          'count' => page_size
        }
      end

      def page_array
        @page_array ||= page[self.class::DATA_KEY]
      end

      def page_children
        @page_children ||= page_array.map { |d| self.class::CHILD_CLASS.new @client, d, path }
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
        if options
          @offset = options['start'] if options.key? 'start'
          @page_size = options['page_size'] if options.key? 'page_size'
        end

        invalidate_current_page
      end

      def invalidate_current_page
        @page = @page_array = @page_children = nil
      end
    end
  end
end
