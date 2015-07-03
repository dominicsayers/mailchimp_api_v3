require 'mailchimp/member'

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
