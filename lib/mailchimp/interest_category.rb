require 'mailchimp/interest'

module Mailchimp
  class List
    class InterestCategory
      PATH_KEY = 'interest-categories'
      DATA_KEY = 'categories'
      VALID_TYPES = %w(checkboxes dropdown radio hidden)
      include Instance

      def interests
        collection Interest
      end

      def update(data, options = { check_id: true })
        fail_unless_id_in data if options[:check_id]
        @client.post path, data
      end
    end
  end
end
