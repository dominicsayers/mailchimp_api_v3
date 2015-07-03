require 'mailchimp_api_v3/interest_category'

module Mailchimp
  class List
    class InterestCategories < Array
      PATH_KEY = 'interest-categories'
      DATA_KEY = 'categories'
      CHILD_CLASS = InterestCategory

      include Collection
    end
  end
end
