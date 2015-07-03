require 'mailchimp/members'
require 'mailchimp/interest_categories'

module Mailchimp
  class List
    include Instance::InstanceMethods
    extend Instance::ClassMethods

    def members(options = {})
      # Turn an email into an id
      if options.is_a?(String) && (options =~ /\A[^@]+@[^@]+\z/)
        options = OpenSSL::Digest.digest('MD5', options).unpack('H*').first
      end

      subclass_from Members, options
    end

    def interest_categories(options = {})
      subclass_from InterestCategories, options
    end

    def id_and_name
      "#{id}___#{name}"
    end
  end
end
