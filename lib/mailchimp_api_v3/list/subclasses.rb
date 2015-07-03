require 'mailchimp_api_v3/member'
require 'mailchimp_api_v3/interest_category'

module Mailchimp
  class List
    module Subclasses
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
    end
  end
end
