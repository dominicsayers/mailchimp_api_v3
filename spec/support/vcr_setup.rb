# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  # c.debug_logger = File.open('tmp/vcr_debug.log', 'w')
  c.hook_into :webmock

  c.default_cassette_options = {
    # record: :new_episodes,
    erb: true,
    decode_compressed_response: true,
    match_requests_on: %i(method uri headers body),
    allow_playback_repeats: false
  }
end
