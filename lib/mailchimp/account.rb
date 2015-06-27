module Mailchimp
  class Account
    KEY = ''
    include Base

    def id
      account_id
    end

    def name
      account_name
    end
  end
end
