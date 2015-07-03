module MailchimpAPIV3
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

      def update(new_data)
        invalidate_derived_fields
        super parse_name_from(new_data)
      end

      private

      def invalidate_derived_fields
        @first_name = @last_name = @name = nil
      end

      def parse_name_from(new_data)
        clean_data = new_data.deep_stringify_keys
        fname, lname = name_parts_from clean_data

        merge_fields = {}
        merge_fields['FNAME'] = fname if fname
        merge_fields['LNAME'] = lname if lname
        additional_data = merge_fields.empty? ? {} : { 'merge_fields' => merge_fields }

        additional_data.merge clean_data
      end

      def name_parts_from(clean_data)
        new_name = clean_data.delete('name')
        name_parts = new_name ? new_name.split : []

        [
          clean_data.delete('first_name') || name_parts[0],
          clean_data.delete('last_name') || name_parts[1]
        ]
      end
    end
  end
end
