module Mailchimp
  class Client < Instance
    include Remote

    def account
      Account.new self, get(path)
    end

    def lists(*args)
      subclass_from Lists, *args
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

      raise(
        Mailchimp::Exception::APIKeyError,
        'detail' => "Invalid API key format: #{@api_key}"
      ) unless api_key_valid?

      @extra_headers = extra_headers
      super self, { 'id' => '3.0' }
    end

    def api_key_valid?
      @api_key =~ /\w+-\w{3}/
    end

    def dc
      @dc ||= @api_key.split('-')[1]
    end
  end
end
