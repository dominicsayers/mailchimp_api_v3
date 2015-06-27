require 'mailchimp/version'
require 'mailchimp/client'

module Mailchimp
  def self.connect(api_key = nil)
    Client.new api_key
  end
end
