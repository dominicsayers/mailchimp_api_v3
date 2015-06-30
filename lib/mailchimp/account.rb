module Mailchimp
  class Account
    PATH_KEY = DATA_KEY = ''
    include Base

    def id
      account_id
    end

    def name
      account_name
    end
  end
end
