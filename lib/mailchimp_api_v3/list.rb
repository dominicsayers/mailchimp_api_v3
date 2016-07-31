module Mailchimp
  class List < Instance
    def members(options = {})
      id = options.convert_to_id if options.is_a?(String) && options.could_be_an_email?
      subclass_from Members, (id || options)
    end

    def interest_categories(options = {})
      subclass_from InterestCategories, options
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end

  class Lists < Collection
    PATH_KEY = DATA_KEY = 'lists'.freeze
    CHILD_CLASS = List
  end
end
