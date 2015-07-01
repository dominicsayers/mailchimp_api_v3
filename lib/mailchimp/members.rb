require 'mailchimp/member'

module Mailchimp
  class List
    class Members < Array
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

      include Collection
    end
  end
end
