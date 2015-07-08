module Mailchimp
  class Client < Instance
    include Remote

    def account
      Account.new self, get
    end

    def lists(filter = {})
      raw_data = filter.respond_to?(:dup) ? filter.dup : filter
      data = raw_data.is_a?(String) ? { name: raw_data } : raw_data
      lists = Lists.new(self)
      data.empty? ? lists : lists.find_by(data)
    end

    def connected?
      account
    rescue Mailchimp::Exception::APIKeyError
      false
    else
      true
    end

    private

    def initialize(api_key = nil, extra_headers = {})
      @api_key = api_key || ENV['MAILCHIMP_API_KEY']

      fail(
        Mailchimp::Exception::APIKeyError,
        'title' => "Invalid API key format: #{@api_key}"
      ) unless api_key_valid?

      @extra_headers = extra_headers
    end

    def api_key_valid?
      @api_key =~ /\w+-\w{3}/
    end

    def dc
      @dc ||= @api_key.split('-')[1]
    end
  end
end
