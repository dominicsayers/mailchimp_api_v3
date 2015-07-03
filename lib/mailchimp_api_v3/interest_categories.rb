require 'mailchimp_api_v3/interest_category'

module MailchimpAPIV3
  class List
    class InterestCategories < Array
      include Collection

      class << self
        def path_key
          'interest-categories'
        end

        def data_key
          'categories'
        end

        def child_class
          InterestCategory
        end
      end
    end
  end
end
