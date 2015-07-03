require 'mailchimp_api_v3/list'

module Mailchimp
  class Lists < Array
    PATH_KEY = DATA_KEY = 'lists'
    CHILD_CLASS = List

    include Collection
  end
end
