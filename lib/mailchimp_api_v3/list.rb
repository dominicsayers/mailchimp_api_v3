module Mailchimp
  class List < Instance
    require 'mailchimp_api_v3/list/subclasses'
    include Subclasses

    def id_and_name
      "#{id}___#{name}"
    end
  end

  class Lists < Collection
    PATH_KEY = DATA_KEY = 'lists'
    CHILD_CLASS = List
  end
end
