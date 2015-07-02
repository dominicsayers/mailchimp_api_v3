require 'mailchimp/interest'

module Mailchimp
  class List
    class InterestCategory
      class Interests < Array
        include Collection

        class << self
          def path_key
            'interests'
          end

          def data_key
            'interests'
          end

          def child_class
            Interest
          end
        end
      end
    end
  end
end
