require 'mailchimp/interest'

module Mailchimp
  class List
    class InterestCategory
      class Interests < Array
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

        include Collection
      end
    end
  end
end
