module Mailchimp
  class List
    class Member
      include Instance::InstanceMethods
      extend Instance::ClassMethods

      def first_name
        @first_name ||= merge_fields['FNAME']
      end

      def last_name
        @last_name ||= merge_fields['LNAME']
      end

      def name
        return @name if @name
        delim = first_name && last_name ? ' ' : ''
        @name = "#{first_name}#{delim}#{last_name}"
      end
    end
  end
end
