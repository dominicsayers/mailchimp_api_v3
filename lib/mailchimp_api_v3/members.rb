require 'mailchimp_api_v3/member'

module Mailchimp
  class List
    class Members < Array
      include Collection

      class << self
        def path_key
          'members'
        end

        def data_key
          'members'
        end

        def child_class
          Member
        end
      end
    end
  end
end
