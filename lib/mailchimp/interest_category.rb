require 'mailchimp/interests'

module Mailchimp
  class List
    class InterestCategory
      #- VALID_TYPES = %w(checkboxes dropdown radio hidden)

      include Instance::InstanceMethods
      extend Instance::ClassMethods

      def interests(options = {})
        subclass_from Interests, options
      end

      def update(data, options = { check_id: true })
        fail_unless_id_in data if options[:check_id]
        @client.post path, data
      end
    end
  end
end
