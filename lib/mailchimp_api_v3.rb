require 'mailchimp_api_v3/version'
require 'mailchimp_api_v3/client'

module Mailchimp
  def self.connect(api_key = nil)
    Client.new api_key
  end
end

class Hash
  def deep_stringify_keys
    result = {}
    each { |k, v| result[k.to_s] = v.is_a?(Hash) ? v.deep_stringify_keys : v }
    result
  end
end
