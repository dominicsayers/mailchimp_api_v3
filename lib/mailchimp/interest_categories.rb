require 'mailchimp/interest_category'

module Mailchimp
  class List
    class InterestCategories < Array
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

      include Collection
    end
  end
end
