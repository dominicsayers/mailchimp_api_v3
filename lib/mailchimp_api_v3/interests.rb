require 'mailchimp_api_v3/interest'

module Mailchimp
  class List
    class InterestCategory
      class Interests < Array
        PATH_KEY = DATA_KEY = 'interests'
        CHILD_CLASS = Interest

        include Collection
      end
    end
  end
end
