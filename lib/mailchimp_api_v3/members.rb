require 'mailchimp_api_v3/member'

module Mailchimp
  class List
    class Members < Array
      PATH_KEY = DATA_KEY = 'members'
      CHILD_CLASS = Member

      include Collection
    end
  end
end
