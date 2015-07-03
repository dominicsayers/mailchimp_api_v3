require 'mailchimp_api_v3/member'

module Mailchimp
  class List
    class Members < Collection
      PATH_KEY = DATA_KEY = 'members'
      CHILD_CLASS = Member
    end
  end
end
