require 'mailchimp/list'

module Mailchimp
  class Lists < Array
    include Collection

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
  end
end
