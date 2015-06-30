require 'mailchimp/member'
require 'mailchimp/interest_category'

module Mailchimp
  class List
    include Base

    def members
      collection Member
    end

    def interest_categories
      collection InterestCategory
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end
end
