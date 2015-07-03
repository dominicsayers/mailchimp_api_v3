require 'mailchimp_api_v3/interest'

module Mailchimp
  class List
    class InterestCategory
      class Interests < Collection
        PATH_KEY = DATA_KEY = 'interests'
        CHILD_CLASS = Interest
      end
    end
  end
end
