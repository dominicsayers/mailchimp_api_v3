module Mailchimp
  class Account < Instance
    def id
      account_id
    end

    def name
      account_name
    end
  end
end
