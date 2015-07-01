require 'mailchimp/members'
require 'mailchimp/interest_categories'

module Mailchimp
  class List
    include Instance

    def members(options = {})
      Members.new @client, path, options
    end

    def interest_categories(options = {})
      InterestCategories.new @client, path, options
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end
end
