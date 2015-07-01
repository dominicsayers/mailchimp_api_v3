module Mailchimp
  module Collection
    def self.included(base)
      puts "#{self} included in #{base}" # debug
    end

    def initialize(client, parent_path)
      @client = client
      @parent_path = parent_path
      puts "#{self} initialized" # debug
      puts self.class.const_get :PATH_KEY # debug
      puts self.class::PATH_KEY # debug

      # first_page = @client.get(path)[DATA_KEY].map { |d| CHILD_CLASS.new @client, path, d }
      # super first_page
    end

    def path
      # @path ||= "#{@parent_path}/#{PATH_KEY}"
    end
  end
end
