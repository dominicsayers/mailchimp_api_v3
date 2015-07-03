require 'mailchimp_api_v3/interests'

module MailchimpAPIV3
  class List
    class InterestCategory
      #- VALID_TYPES = %w(checkboxes dropdown radio hidden)

      include Instance::InstanceMethods
      extend Instance::ClassMethods

      def interests(options = {})
        subclass_from Interests, options
      end
    end
  end
end
