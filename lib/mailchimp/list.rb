require 'mailchimp/members'
require 'mailchimp/interest_categories'

module Mailchimp
  class List
    include Instance

    def members
      Members.new @client, path
    end

    def interest_categories
      InterestCategories.new @client, path
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end
end
