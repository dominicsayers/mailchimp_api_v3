require 'mailchimp_api_v3/version'
require 'mailchimp_api_v3/collection/paging'
require 'mailchimp_api_v3/collection'
require 'mailchimp_api_v3/instance'
require 'mailchimp_api_v3/exception'
require 'mailchimp_api_v3/client/remote'
require 'mailchimp_api_v3/client'
require 'mailchimp_api_v3/account'
require 'mailchimp_api_v3/list'
require 'mailchimp_api_v3/member'
require 'mailchimp_api_v3/interest_category'
require 'mailchimp_api_v3/interest'

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

  def divide_on(*keys)
    keys.each_with_object(self.class.new) do |k, hash|
      hash[k] = self[k] if key?(k)
      delete k
    end
  end
end

class String
  def could_be_an_email?
    self =~ /\A[^@]+@[^@]+\z/
  end

  def convert_to_id
    OpenSSL::Digest.digest('MD5', downcase).unpack('H*').first
  end
end
