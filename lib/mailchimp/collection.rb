module Mailchimp
  module Collection
    def initialize(client, parent_path)
      @client = client
      @parent_path = parent_path

      first_page = @client.get(path, self.class.data_key).map { |d| self.class.child_class.new @client, path, d }
      super first_page
    end

    def path
      @path ||= "#{@parent_path}/#{self.class.path_key}"
    end
  end
end
