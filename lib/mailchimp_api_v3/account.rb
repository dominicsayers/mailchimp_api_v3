module Mailchimp
  class Account
    include Instance::InstanceMethods

    def id
      account_id
    end

    def name
      account_name
    end
  end
end
