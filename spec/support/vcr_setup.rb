require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock

  c.default_cassette_options = {
    record: :new_episodes,
    decode_compressed_response: true,
    match_requests_on: [:method, :uri, :headers]
  }
end
