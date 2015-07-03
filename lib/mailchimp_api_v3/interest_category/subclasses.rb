require 'mailchimp_api_v3/interest'

module Mailchimp
  class List
    class InterestCategory
      module Subclasses
        #- VALID_TYPES = %w(checkboxes dropdown radio hidden)
        def interests(options = {})
          subclass_from Interests, options
        end
      end
    end
  end
end
