require 'mailchimp/member'

module Mailchimp
  class List
    KEY = 'lists'
    include Base

    def members
      collection Member
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end
end
