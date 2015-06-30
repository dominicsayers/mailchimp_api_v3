module Mailchimp
  class List
    class Member
      PATH_KEY = DATA_KEY = 'members'
      include Base

      def name
        return @name if @name
        fname = merge_fields['FNAME']
        lname = merge_fields['LNAME']
        delim = fname && lname ? ' ' : ''
        @name = "#{fname}#{delim}#{lname}"
      end
    end
  end
end
