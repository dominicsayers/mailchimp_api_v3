module Mailchimp
  class List
    class Member < Instance
      # Class methods

      def self.add_id_to(data)
        clean_data = data.deep_stringify_keys
        return clean_data unless clean_data.key? 'email_address'
        clean_data.merge id: clean_data['email_address'].convert_to_id
      end

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

      # Instance methods

      def first_name
        merge_fields['FNAME']
      end

      def last_name
        merge_fields['LNAME']
      end

      def name
        delim = first_name && last_name ? ' ' : ''
        "#{first_name}#{delim}#{last_name}"
      end

      def to_s
        "#{name} <#{email_address}>"
      end

      def update(new_data)
        super self.class.parse_name_from(new_data)
      end
    end

    class Members < Collection
      PATH_KEY = DATA_KEY = 'members'.freeze
      CHILD_CLASS = Member

      def create(data)
        super Mailchimp::List::Member.parse_name_from(data)
      end

      def create_or_update(data)
        super Mailchimp::List::Member.add_id_to(data)
      end
    end
  end
end
