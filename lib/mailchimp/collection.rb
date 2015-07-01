module Mailchimp
  module Collection
    def initialize(client, parent_path)
      @client = client
      @parent_path = parent_path

      first_page = @client.get(path)[DATA_KEY].map { |d| CHILD_CLASS.new @client, path, d }
      super first_page
    end

    def path
      @path ||= "#{@parent_path}/#{PATH_KEY}"
    end
  end
end
