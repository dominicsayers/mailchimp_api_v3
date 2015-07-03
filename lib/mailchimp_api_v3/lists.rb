require 'mailchimp_api_v3/list'

module Mailchimp
  class Lists < Collection
    PATH_KEY = DATA_KEY = 'lists'
    CHILD_CLASS = List
  end
end
