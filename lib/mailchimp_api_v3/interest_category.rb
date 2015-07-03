module Mailchimp
  class List
    class InterestCategory < Instance
      require 'mailchimp_api_v3/interest_category/subclasses'
      include Subclasses
    end

    class InterestCategories < Collection
      PATH_KEY = 'interest-categories'
      DATA_KEY = 'categories'
      CHILD_CLASS = InterestCategory
    end
  end
end
