module Mailchimp
  class List
    class InterestCategory < Instance
      #- VALID_TYPES = %w(checkboxes dropdown radio hidden)

      def interests(options = {})
        subclass_from Interests, options
      end
    end

    class InterestCategories < Collection
      NAME_FIELD = 'title'
      PATH_KEY = 'interest-categories'
      DATA_KEY = 'categories'
      CHILD_CLASS = InterestCategory
    end
  end
end
