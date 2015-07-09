module Mailchimp
  class List
    class Member < Instance
      def self.parse_name_from(data)
        clean_data = data.deep_stringify_keys
        fname, lname = name_parts_from clean_data

        merge_fields = {}
        merge_fields['FNAME'] = fname if fname
        merge_fields['LNAME'] = lname if lname
        additional_data = merge_fields.empty? ? {} : { 'merge_fields' => merge_fields }

        additional_data.merge clean_data
      end

      def self.name_parts_from(data)
        new_name = data.delete('name')
        name_parts = new_name ? new_name.split : []

        [
          data.delete('first_name') || name_parts[0],
          data.delete('last_name') || name_parts[1]
        ]
      end

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

      def update(new_data)
        invalidate_derived_fields
        super self.class.parse_name_from(new_data)
      end

      private

      def invalidate_derived_fields
        @first_name = @last_name = @name = nil
      end
    end

    class Members < Collection
      PATH_KEY = DATA_KEY = 'members'
      CHILD_CLASS = Member

      def create(data)
        super Mailchimp::List::Member.parse_name_from(data)
      end
    end
  end
end
