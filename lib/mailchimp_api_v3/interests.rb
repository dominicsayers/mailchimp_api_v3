require 'mailchimp_api_v3/interest'

module MailchimpAPIV3
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
