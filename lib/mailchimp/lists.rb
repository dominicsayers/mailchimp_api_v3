require 'mailchimp/list'

module Mailchimp
  class Lists < Array
    class << self
      def path_key
        'lists'
      end

      def data_key
        'lists'
      end

      def child_class
        List
      end
    end

    include Collection
  end
end
